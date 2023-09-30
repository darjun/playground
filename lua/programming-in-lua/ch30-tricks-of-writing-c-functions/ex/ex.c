#include "lua.h"
#include "lauxlib.h"

static int l_filter(lua_State *L) {
	// 检查第一个参数必须是表
	luaL_checktype(L, 1, LUA_TTABLE);

	// 检查第二个参数必须是函数
	luaL_checktype(L, 2, LUA_TFUNCTION);

	// 返回值 table
	lua_newtable(L);

	int n = luaL_len(L, 1);
	int idx = 0;
	for (int i = 1; i <= n; i++) {
		lua_pushvalue(L, 2); // 压入函数
		lua_rawgeti(L, 1, i); // 获取表中元素
		lua_call(L, 1, 1); // 调用过滤器函数

		// 检查过滤器结果
		if (lua_toboolean(L, -1)) {
			lua_pushvalue(L, 2);
			lua_rawseti(L, 3, idx++);
		}
		lua_pop(L, 1); // 移除过滤器的结果
	}
	return 1;
}

static const struct luaL_Reg mylib[] = {
	{"filter", l_filter},
	{NULL, NULL},
};

int luaopen_ex(lua_State *L) {
	luaL_newlib(L, mylib);
	return 1;
}