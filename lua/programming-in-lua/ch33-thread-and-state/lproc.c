#include <pthread.h>
#include <string.h>

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

typedef struct Proc {
  lua_State *L;
  pthread_t thread;
  pthread_cond_t cond;
  const char *channel;
  struct Proc *previous, *next;
} Proc;

static Proc *waitsend = NULL;
static Proc *waitreceive = NULL;

static pthread_mutex_t kernel_access = PTHREAD_MUTEX_INITIALIZER;

static Proc *getself (lua_State *L) {
  Proc *p;
  lua_getfield(L, LUA_REGISTRYINDEX, "_SELF");
  p = (Proc *)lua_touserdata(L, -1);
  lua_pop(L, 1);
  return p;
}

static void movevalues (lua_State *send, lua_State *rec) {
  int n = lua_gettop(send);
  int i;
  luaL_checkstack(rec, n, "too many results");
  for (i = 2; i <= n; i++) /* 将值传给接收进程 */
    lua_pushstring(rec, lua_tostring(send, i));
}

static Proc *searchmatch (const char *channel, Proc **list) {
  Proc *node;
  /* 遍历列表 */
  for (node = *list; node != NULL; node = node->next) {
    if (strcmp(channel, node->channel) == 0) { /* 匹配？ */
      /* 将节点从列表中移除 */
      if (*list == node) /* 节点是否为第一个元素？ */
        *list = (node->next == node) ? NULL : node->next;
      node->previous->next = node->next;
      node->next->previous = node->previous;
      return node;
    }
  }
  return NULL; /* 没有找到匹配 */
}

static void waitonlist (lua_State *L, const char *channel,
                                      Proc **list) {
  Proc *p = getself(L);

  /* 将自身放到链表的末尾 */
  if (*list == NULL) { /* 链表为空？ */
    *list = p;
    p->previous = p->next = p;
  }
  else {
    p->previous = (*list)->previous;
    p->next = *list;
    p->previous->next = p->next->previous = p;
  }

  p->channel = channel; /* 等待的通道 */

  do { /* 等待其条件变量 */
    pthread_cond_wait(&p->cond, &kernel_access);
  } while (p->channel);
}

static int ll_send (lua_State *L) {
  Proc *p;
  const char *channel = luaL_checkstring(L, 1);

  pthread_mutex_lock(&kernel_access);

  p = searchmatch(channel, &waitreceive);

  if (p) { /* 找到匹配的接收线程？ */
    movevalues(L, p->L); /* 将值传递给接收线程 */
    p->channel = NULL; /* 标记接收线程无须再等等 */
    pthread_cond_signal(&p->cond); /* 唤醒接收线程 */
  }
  else
    waitonlist(L, channel, &waitsend);

  pthread_mutex_unlock(&kernel_access);
  return 0;
}

static int ll_receive (lua_State *L) {
  Proc *p;
  const char *channel = luaL_checkstring(L, 1);
  lua_settop(L, 1);

  pthread_mutex_lock(&kernel_access);

  p = searchmatch(channel, &waitsend);

  if (p) { /* 找到匹配的发送线程？ */
    movevalues(p->L, L); /* 从发送线程获取值 */
    p->channel = NULL; /* 标记发送线程无须再等待 */
    pthread_cond_signal(&p->cond); /* 唤醒发送线程 */
  }
  else
    waitonlist(L, channel, &waitreceive);

  pthread_mutex_unlock(&kernel_access);

  /* 返回除通道外的栈中的值 */
  return lua_gettop(L) - 1;
}

int luaopen_lproc (lua_State *L);
static void openlibs (lua_State *L);

static void *ll_thread (void *arg) {
  lua_State *L = (lua_State *)arg;
  Proc *self; /* 进程自身的控制块 */

  openlibs(L); /* 打开标准库 */
  luaL_requiref(L, "lproc", luaopen_lproc, 1);
  lua_pop(L, 1); /* 移除之前调用的结果 */
  self = (Proc *)lua_newuserdata(L, sizeof(Proc));
  lua_setfield(L, LUA_REGISTRYINDEX, "_SELF");
  self->L = L;
  self->thread = pthread_self();
  self->channel = NULL;
  pthread_cond_init(&self->cond, NULL);

  if (lua_pcall(L, 0, 0, 0) != 0) /* 调用主代码段 */
    fprintf(stderr, "thread error: %s", lua_tostring(L, -1));

  pthread_cond_destroy(&getself(L)->cond);
  lua_close(L);
  return NULL;
}

static int ll_start (lua_State *L) {
  pthread_t thread;

  const char *chunk = luaL_checkstring(L, 1);
  lua_State *L1 = luaL_newstate();

  if (L1 == NULL)
    luaL_error(L, "unable to create new state");

  if (luaL_loadstring(L1, chunk) != 0)
    luaL_error(L, "error in thread body: %s",
                  lua_tostring(L1, -1));

  if (pthread_create(&thread, NULL, ll_thread, L1) != 0)
    luaL_error(L, "unable to create new thread");

  pthread_detach(thread);
  return 0;
}

static int ll_exit (lua_State *L) {
  pthread_exit(NULL);
  return 0;
}

static const struct luaL_Reg ll_funcs[] = {
  {"start", ll_start},
  {"send", ll_send},
  {"receive", ll_receive},
  {"exit", ll_exit},
  {NULL, NULL}
};

int luaopen_lproc (lua_State *L) {
  luaL_newlib(L, ll_funcs);
  return 1;
}

static void registerlib (lua_State *L, const char *name,
                          lua_CFunction f) {
  lua_getglobal(L, "package");
  lua_getfield(L, -1, "preload"); /* 获取 'package.preload' */
  lua_pushcfunction(L, f);
  lua_setfield(L, -2, name); /* package.preload[name] = f */
  lua_pop(L, 2); /* 弹出'package'和'preload' */
}

static void openlibs (lua_State *L) {
  luaL_requiref(L, "_G", luaopen_base, 1);
  luaL_requiref(L, "package", luaopen_package, 1);
  lua_pop(L, 2); /* 移除之前调用的结果 */
  registerlib(L, "coroutine", luaopen_coroutine);
  registerlib(L, "table", luaopen_table);
  registerlib(L, "io", luaopen_io);
  registerlib(L, "os", luaopen_os);
  registerlib(L, "string", luaopen_string);
  registerlib(L, "math", luaopen_math);
  registerlib(L, "utf8", luaopen_utf8);
  registerlib(L, "debug", luaopen_debug);
}