#include "lua.h"
#include "lauxlib.h"

int l_map (lua_State *L) {
  int i, n;

  /* 第一个参数必须是一张表（t） */
  luaL_checktype(L, 1, LUA_TTABLE);

  /* 第二个参数必须是一个函数（f） */
  luaL_checktype(L, 2, LUA_TFUNCTION);

  n = luaL_len(L, 1); /* 获取表的大小 */

  for (i = 1; i <= n; i++) {
    lua_pushvalue(L, 2); /* 压入f */
    lua_geti(L, 1, i); /* 压入t[i] */
    lua_call(L, 1, 1); /* 调用 f(t[i]) */
    lua_seti(L, 1, i); /* t[i] = result */
  }

  return 0; /* 没有返回值 */
}