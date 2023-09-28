#include <dirent.h>
#include <errno.h>
#include <string.h>

#include "lua.h"
#include "lauxlib.h"

static int l_dir (lua_State *L) {
    DIR *dir;
    struct dirent *entry;
    int i;
    const char *path = luaL_checkstring(L, 1);

    /* 打开目录 */
    dir = opendir(path);
    if (dir == NULL) { /* 打开目录失败？ */
        lua_pushnil(L); /* 返回nil... */
        lua_pushstring(L, strerror(errno)); /* 和错误信息 */
        return 2; /* 结果数量 */
    }

    /* 创建结果表 */
    lua_newtable(L);
    i = 1;
    while ((entry = readdir(dir)) != NULL) { /* 对于目录中的每一个元素 */
        lua_pushinteger(L, i++); /* 压入键 */
        lua_pushstring(L, entry->d_name); /* 压入值 */
        lua_settable(L, -3); /* table[i] = 元素名 */
    }

    closedir(dir);
    return 1; /* 表本身就在栈顶 */
}