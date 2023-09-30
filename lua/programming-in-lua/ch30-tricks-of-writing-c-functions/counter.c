#include "lua.h"
#include "lauxlib.h"

static int counter (lua_State *L); /* 前向声明 */

static int newCounter (lua_State *L) {
	lua_pushinteger(L, 0);
	lua_pushcclosure(L, &counter, 1);
	return 1;
}

static int counter (lua_State *L) {
	int val = lua_tointeger(L, lua_upvalueindex(1));
	lua_pushinteger(L, ++val); /* 新值 */
	lua_copy(L, -1, lua_upvalueindex(1)); /* 更新上值 */
	return 1; /* 返回新值 */
}

static const luaL_Reg mylib[] = {
	{"newCounter", newCounter},
	{NULL, NULL}
};

int luaopen_counter(lua_State* L) {
	luaL_newlib(L, mylib);
	return 1;
}