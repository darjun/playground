#include "lua.h"
#include "lauxlib.h"

static int l_split (lua_State *L) {
	const char *s = luaL_checkstring(L, 1);
	const char *sep = luaL_checkstring(L, 2);
	const char *e;
	int i = 1;

	lua_newtable(L); /* 结果表 */

	/* 依次处理每个分隔符 */
	while ((e = strchr(s, sep)) != NULL) {
		lua_pushlstring(L, s, e - s); /* 压入子串 */
		lua_rawseti(L, -2, i++); /* 向表中插入 */
		s = e + 1; /* 跳过分隔符 */
	}

	/* 插入最后一个子串 */
	lua_pushstring(L, s);
	lua_rawseti(L, -2, i);

	return 1; /* 将结果表返回 */
}