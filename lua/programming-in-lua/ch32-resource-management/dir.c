#include <dirent.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>

#include "lua.h"
#include "lauxlib.h"

/* 迭代函数的前向声明 */
static int dir_iter (lua_State *L);

static int l_dir (lua_State *L) {
	const char *path = luaL_checkstring(L, 1);

	/* 创建一个保存 DIR 结构体的用户数据 */
	DIR **d = (DIR **)lua_newuserdata(L, sizeof(DIR *));

	/* 预先初始化 */
	*d = NULL;

	/* 设置元表 */
	luaL_getmetatable(L, "LuaBook.dir");
	lua_setmetatable(L, -2);

	/* 尝试打开目录 */
	*d = opendir(path);
	if (*d == NULL) /* 打开目录失败？ */
		luaL_error(L, "cannot open %s: %s", path, strerror(errno));

	/* 创建并返回迭代函数；该函数唯一的上值，即代表目录的用户数据本身就位于栈顶 */
	lua_pushcclosure(L, &dir_iter, 1);
	return 1;
}

static int dir_iter (lua_State *L) {
	DIR *d = *(DIR **) lua_touserdata(L, lua_upvalueindex(1));
	struct dirent *entry = readdir(d);
	if (entry != NULL) {
		lua_pushstring(L, entry->d_name);
		return 1;
	}

	return 0; /* 迭代完成 */
}

static int dir_gc (lua_State *L) {
	DIR *d = *(DIR **)lua_touserdata(L, 1);
	if (d) closedir(d);
	return 0;
}

static const struct luaL_Reg dirlib [] = {
	{"open", l_dir},
	{NULL, NULL}
};

int luaopen_dir (lua_State *L) {
	luaL_newmetatable(L, "LuaBook.dir");

	/* 设置 __gc 字段 */
	lua_pushcfunction(L, dir_gc);
	lua_setfield(L, -2, "__gc");

	/* 创建库 */
	luaL_newlib(L, dirlib);
	return 1;
}