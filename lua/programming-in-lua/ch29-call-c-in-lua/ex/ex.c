#include <dirent.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

#include "lua.h"
#include "lauxlib.h"

static int l_summation (lua_State *L) {
    double sum = 0;

    int narg = lua_gettop(L);
    for (int i = 1; i <= narg; i++) {
        double num = luaL_checknumber(L, i);
        sum += num;
    }

    lua_pushnumber(L, sum);
    return 1;
}

static int l_tablepack (lua_State *L) {
    lua_newtable(L); // create a new table
    int narg = lua_gettop(L) - 1;
    for (int i = 1; i <= narg; i++) {
        lua_pushinteger(L, i);
        lua_pushvalue(L, i);
        lua_settable(L, -3);
    }
    lua_pushstring(L, "n");
    lua_pushnumber(L, narg);
    lua_settable(L, -3);
    return 1;
}

static int l_reverse (lua_State *L) {
    int narg = lua_gettop(L);
    for (int i = narg; i >= 1; i--) {
        lua_pushvalue(L, i);
    }

    return narg;
}

void error (lua_State *L, const char *fmt, ...) {
    va_list argp;
    va_start(argp, fmt);
    vfprintf(stderr, fmt, argp);
    va_end(argp);
    lua_close(L);
    exit(EXIT_FAILURE);
}

static int l_foreach (lua_State *L) {
    lua_pushnil(L);
    while (lua_next(L, 1) != 0) {
        lua_pushvalue(L, 2); // 复制要调用的函数
        lua_pushvalue(L, -3); // 复制一份键值
        lua_pushvalue(L, -3);
        if ((lua_pcall(L, 2, LUA_MULTRET, 0)) != LUA_OK)
            fprintf(stderr, "call failed: %s\n", lua_tostring(L, -1));
        lua_pop(L, 1); // 移除值，留下键
    }
    return 0;
}

static const struct luaL_Reg mylib[] = {
    {"summation", l_summation},
    {"tablepack", l_tablepack},
    {"reverse", l_reverse},
    {"foreach", l_foreach},
    {NULL, NULL} /* 哨兵 */
};

int luaopen_ex (lua_State *L) {
    luaL_newlib(L, mylib);
    return 1;
}