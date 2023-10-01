#include <stdlib.h>

#include "expat.h"
#include "lua.h"
#include "lauxlib.h"

typedef struct lxp_userdata {
	XML_Parser parser; /* 关联的Expat解析器 */
	lua_State *L;
} lxp_userdata;

/* 回调函数的前向声明 */
static void f_StartElement (void *ud,
							const char *name,
							const char **atts);
static void f_CharData (void *ud, const char *s, int len);
static void f_EndElement (void *ud, const char *name);

static int lxp_make_parser (lua_State *L) {
	XML_Parser p;

	/* (1) 创建解析器对象 */
	lxp_userdata *xpu = (lxp_userdata *)lua_newuserdata(L, sizeof(lxp_userdata));

	/* 预先初始化以防止错误发生 */
	xpu->parser = NULL;

	/* 设置元表 */
	luaL_getmetatable(L, "Expat");
	lua_setmetatable(L, -2);

	/* (2) 创建Expat解析器 */
	p = xpu->parser = XML_ParserCreate(NULL);
	if (!p)
		luaL_error(L, "XML_ParserCreate failed");

	/* (3) 检查并保存回调函数表 */
	luaL_checktype(L, 1, LUA_TTABLE);
	lua_pushvalue(L, 1); /* 回调函数表入栈 */
	lua_setuservalue(L, -2); /* 将回到函数表设为用户值 */

	/* (4) 设置Expat解析器 */
	XML_SetUserData(p, xpu);

	XML_SetElementHandler(p, f_StartElement, f_EndElement);
	XML_SetCharacterDataHandler(p, f_CharData);
	return 1;
}

static int lxp_parse (lua_State *L) {
	int status;
	size_t len;
	const char *s;
	lxp_userdata *xpu;

	/* get and check first argument (should be a parser) */
	xpu = (lxp_userdata *)luaL_checkudata(L, 1, "Expat");

	/* check if it is not closed */
	luaL_argcheck(L, xpu->parser != NULL, 1, "parser is closed");

	/* get second argument (a string) */
	s = luaL_optlstring(L, 2, NULL, &len);

	/* put callback table at stack index 3 */
	lua_settop(L, 2);
	lua_getuservalue(L, 1);

	xpu->L = L; /* set Lua state */

	/* call Expat to parse string */
	status = XML_Parse(xpu->parser, s, (int)len, s == NULL);

	/* return error code */
	lua_pushboolean(L, status);
	return 1;
}

static void f_CharData (void *ud, const char *s, int len) {
	lxp_userdata *xpu = (lxp_userdata *)ud;
	lua_State *L = xpu->L;

	/* 从回调函数表中获取处理函数 */
	lua_getfield(L, 3, "CharacterData");

	if (lua_isnil(L, -1)) { /* 没有处理函数？ */
		lua_pop(L, 1);
		return;
	}

	lua_pushvalue(L, 1); /* 解析器压栈（'self'） */
	lua_pushlstring(L, s, len); /* 压入字符数据 */
	lua_call(L, 2, 0); /* 调用处理函数 */
}

static void f_EndElement (void *ud, const char *name) {
	lxp_userdata *xpu = (lxp_userdata *)ud;
	lua_State *L = xpu->L;

	lua_getfield(L, 3, "EndElement");
	if (lua_isnil(L, -1)) { /* 没有处理函数？ */
		lua_pop(L, 1);
		return;
	}

	lua_pushvalue(L, 1); /* 解析器压栈（'self'） */
	lua_pushstring(L, name); /* 压入标签名 */
	lua_call(L, 2, 0); /* 调用处理函数 */
}

static void f_StartElement (void *ud,
							const char *name,
							const char **atts) {
	lxp_userdata *xpu = (lxp_userdata *)ud;
	lua_State *L = xpu->L;

	lua_getfield(L, 3, "StartElement");
	if (lua_isnil(L, -1)) { /* 没有处理函数？ */
		lua_pop(L, 1);
		return;
	}

	lua_pushvalue(L, 1); /* 解析器压栈（'self'） */
	lua_pushstring(L, name); /* 压入标签名 */

	/* 创建并填充属性表 */
	lua_newtable(L);
	for (; *atts; atts += 2) {
		lua_pushstring(L, *(atts + 1));
		lua_setfield(L, -2, *atts); /* table[*atts] = *(atts+1) */
	}

	lua_call(L, 3, 0); /* 调用处理器函数 */
}

static int lxp_close (lua_State *L) {
	lxp_userdata *xpu = (lxp_userdata *)luaL_checkudata(L, 1, "Expat");

	/* 释放Expat解析器（如果有）*/
	if (xpu->parser)
		XML_ParserFree(xpu->parser);
	xpu->parser = NULL; /* 避免重复关闭 */
	return 0;
}

static const struct luaL_Reg lxp_meths[] = {
	{"parse", lxp_parse},
	{"close", lxp_close},
	{"__gc", lxp_close},
	{NULL, NULL}
};

static const struct luaL_Reg lxp_funcs[] = {
	{"new", lxp_make_parser},
	{NULL, NULL}
};

int luaopen_lxp (lua_State *L) {
	/* 创建元表 */
	luaL_newmetatable(L, "Expat");

	/* metatable.__index = metatable */
	lua_pushvalue(L, -1);
	lua_setfield(L, -2, "__index");

	/* 注册方法 */
	luaL_setfuncs(L, lxp_meths, 0);

	/* 注册（只有 lxp.new） */
	luaL_newlib(L, lxp_funcs);
	return 1;
}