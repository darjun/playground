#include "lua.h"
#include "lauxlib.h"

#define MAX_COLOR 255

/* 假设表位于栈顶 */
int getcolorfield (lua_State *L, const char *key) {
    int result, isnum;
    lua_pushstring(L, key); /* 压入键 */
    lua_gettable(L, -2); /* 获取 background[key] */
    result = (int) (lua_tonumberx(L, -1, &isnum) * MAX_COLOR);
    if (!isnum)
        error(L, "invalid component '%s' in color", key);
    lua_pop(L, 1); /* 移除数值 */
    return result;
}

void load (lua_State *L) {
    lua_getglobal(L, "background");
    if (!lua_istable(L, -1))
        error(L, "'background' is not a table");

    int red = getcolorfield(L, "red");
    int green = getcolorfield(L, "green");
    int blue = getcolorfield(L, "blue");
}