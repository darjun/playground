#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

void call_va (lua_State *L, const char *func,
                            const char *sig, ...) {
    va_list vl;
    int narg, nres; /* 参数和结果的个数 */

    va_start(vl, sig);
    lua_getglobal(L, func); /* 函数压栈 */

    for (narg = 0; *sig; narg++) { /* 对于每一个参数循环 */
        /* 检查栈空间 */
        luaL_checkstack(L, 1, "too many arguments");

        switch (*sig++) {
            case 'd': /* double 类型的参数 */
                lua_pushnumber(L, va_arg(vl, double));
                break;

            case 'i': /* int 类型的参数 */
                lua_pushinteger(L, va_arg(vl, int));
                break;

            case 's': /* string 类型的参数 */
                lua_pushstring(L, va_arg(vl, char *));
                break;

            case '>': /* 参数部分结束 */
                goto endargs; /* 从循环中跳出 */

            default:
                error(L, "invalid option (%c)", *(sig-1));
        }
    }
    endargs:

    nres = strlen(sig); /* 期望的结果数 */

    if (lua_pcall(L, narg, nres, 0) != 0) /* 进行调用 */
        error(L, "error calling '%s': %s", func,
                                            lua_tostring(L, -1));


    nres = -nres; /* stack index of first result */
    while (*sig) { /* repeat for each result */
        switch (*sig++) {
            case 'd': { /* double result */
                int isnum;
                double n = lua_tonumberx(L, nres, &isnum);
                if (!isnum)
                    error(L, "wrong result type");
                *va_arg(vl, double *) = n;
                break;
            }

            case 'i': { /* int result */
                int isnum;
                int n = lua_tointegerx(L, nres, &isnum);
                if (!isnum)
                    error(L, "wrong result type");
                *va_arg(vl, int *) = n;
                break;
            }

            case 's': { /* string result */
                const char *s = lua_tostring(L, nres);
                if (s == NULL)
                    error(L, "wrong result type");
                *va_arg(vl, const char **) = s;
                break;
            }

            default:
                error(L, "invalid option (%c)", *(sig-1));
        }
        nres++;
    }

    va_end(vl);
}