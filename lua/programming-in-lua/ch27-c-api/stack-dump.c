#include <stdio.h>
#include "lua.h"
#include "lauxlib.h"

static void stackDump (lua_State *L) {
    int i;
    int top = lua_gettop(L); /* 栈的深度 */
    for (i = 1; i <= top; i++) { /* 循环 */
        int t = lua_type(L, i);
        switch (t) {
            case LUA_TSTRING: { /* 字符串类型 */
                printf("'%s'", lua_tostring(L, i));
                break;
            }
            case LUA_TBOOLEAN: { /* 布尔类型 */
                printf(lua_toboolean(L, i) ? "true" : "false");
                break;
            }
            case LUA_TNUMBER: { /* 数值类型 */
                if (lua_isinteger(L, i)) /* 整型？ */
                    printf("%lld", lua_tointeger(L, i));
                else /* 浮点型 */
                    printf("%g", lua_tonumber(L, i));
                break;
            }
            default: { /* 其他类型 */
                printf("%s", lua_typename(L, t));
                break;
            }
        }
        printf("  "); /* 输出分隔符 */
    }
    printf("\n"); /* 换行符 */
}

int main (void) {
    lua_State *L = luaL_newstate();

    lua_pushboolean(L, 1);
    lua_pushnumber(L, 10);
    lua_pushnil(L);
    lua_pushstring(L, "hello");

    stackDump(L);
    /* 将输出： true 10 nil 'hello' */

    lua_pushvalue(L, -4); stackDump(L);
    /* 将输出： true 10 nil 'hello' true */

    lua_replace(L, 3); stackDump(L);
    /* 将输出： true 10 true 'hello' */ 

    lua_settop(L, 6); stackDump(L);
    /* 将输出： true 10 true 'hello' nil nil */

    lua_rotate(L, 3, 1); stackDump(L);
    /* 将输出： true 10 nil true 'hello' nil */

    lua_remove(L, -3); stackDump(L);
    /* 将输出： true 10 nil 'hello' nil */

    lua_settop(L, -5); stackDump(L);
    /* 将输出： true */

    lua_close(L);
    return 0;
}