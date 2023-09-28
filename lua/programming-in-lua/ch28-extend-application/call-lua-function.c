#include <stdio.h>
#include <stdlib.h>

#include "lua.h"
#include "lauxlib.h"

void error (lua_State *L, const char *fmt, ...) {
    va_list argp;
    va_start(argp, fmt);
    vfprintf(stderr, fmt, argp);
    va_end(argp);
    lua_close(L);
    exit(EXIT_FAILURE);
}

/* 调用 Lua 语言中定义的函数'f' */
double f (lua_State *L, double x, double y) {
    int isnum;
    double z;

    /* 函数和参数压栈 */
    lua_getglobal(L, "f"); /* 要调用的函数 */
    lua_pushnumber(L, x);  /* 压入第一个参数 */
    lua_pushnumber(L, y);  /* 压入第二个参数 */

    /* 进行调用（两个参数，一个结果） */
    if (lua_pcall(L, 2, 1, 0) != LUA_OK)
        error(L, "error running function 'f': %s",
                    lua_tostring(L, -1));

    /* 获取结果 */
    z = lua_tonumberx(L, -1, &isnum);
    if (!isnum)
        error(L, "function 'f' should return a number");

    lua_pop(L, 1); /* 弹出返回值 */
    return z;
}