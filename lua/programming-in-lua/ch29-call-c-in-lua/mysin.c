#include <math.h>

#include "lua.h"
#include "lauxlib.h"

static int l_sin (lua_State *L) {
    double d = luaL_checknumber(L, 1);
    lua_pushnumber(L, sin(d));
    return 1;
}