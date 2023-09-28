#include <stdio.h>
#include <stdlib.h>

#include "lua.h"
#include "lualib.h"
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

int main () {
    lua_State *L = luaL_newstate();

    lua_pushnumber(L, 3.5); stackDump(L);
    /* 栈：3.5 */

    lua_pushstring(L, "hello"); stackDump(L);
    /* 栈: 3.5 "hello" */

    lua_pushnil(L); stackDump(L);
    /* 栈：3.5 "hello" nil */

    lua_rotate(L, 1, -1); stackDump(L);
    /* 栈："hello" nil 3.5 */

    lua_pushvalue(L, -2); stackDump(L);
    /* 栈: "hello" nil 3.5 nil */

    lua_remove(L, 1); stackDump(L);
    /* 栈: nil 3.5 nil */

    lua_insert(L, -2); stackDump(L);
    /* 栈: nil nil 3.5 */

    return 0;
}