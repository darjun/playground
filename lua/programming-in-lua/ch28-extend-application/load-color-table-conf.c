#include <string.h>

#include "lua.h"
#include "lauxlib.h"

#define MAX_COLOR 255

struct ColorTable {
    char *name;
    unsigned char red, green, blue;
} colortable[] = {
    {"WHITE", MAX_COLOR, MAX_COLOR, MAX_COLOR},
    {"RED", MAX_COLOR, 0, 0},
    {"GREEN", 0, MAX_COLOR, 0},
    {"BLUE", 0, 0, MAX_COLOR},
    {"NULL", 0, 0, 0}, /* 哨兵 */
};

/* 假设表位于栈顶 */
int getcolorfield (lua_State *L, const char *key) {
    int result, isnum;
    lua_getfield(L, -1, key); /* 获取 background[key] */
    result = (int) (lua_tonumberx(L, -1, &isnum) * MAX_COLOR);
    if (!isnum)
        error(L, "invalid component '%s' in color", key);
    lua_pop(L, 1); /* 移除数值 */
    return result;
}

/* 假设表位于栈顶 */
void setcolorfield (lua_State *L, const char *index, int value) {
    lua_pushnumber(L, (double)value / MAX_COLOR); /* 值 */
    lua_setfield(L, -2, index);
}

void setcolor (lua_State *L, struct ColorTable *ct) {
    lua_newtable(L); /* 创建表 */
    setcolorfield(L, "red", ct->red);
    setcolorfield(L, "green", ct->green);
    setcolorfield(L, "blue", ct->blue);
    lua_setglobal(L, ct->name); /* 'name' = table */
}

void load (lua_State *L) {
    lua_getglobal(L, "background");
    if (!lua_istable(L, -1))
        error(L, "'background' is not a table");

    int red = getcolorfield(L, "red");
    int green = getcolorfield(L, "green");
    int blue = getcolorfield(L, "blue");
}

void load2 (lua_State *L) {
    lua_getglobal(L, "background");
    int red, green, blue;
    if (lua_isstring(L, -1)) { /* 值是一个字符串？ */
        const char *colorname = lua_tostring(L, -1); /* 获取字符串 */
        int i; /* 搜索颜色表 */
        for (i = 0; colortable[i].name != NULL; i++) {
            if (strcmp(colorname, colortable[i].name) == 0)
                break;
        }
        if (colortable[i].name == NULL) /* 没有发现字符串？ */
            error(L, "invalid color name (%s)", colorname);
        else { /* 使用 colortable[i] */
            red = colortable[i].red;
            green = colortable[i].green;
            blue = colortable[i].blue;
        }
    } else if (lua_istable(L, -1)) {
        red = getcolorfield(L, "red");
        green = getcolorfield(L, "green");
        blue = getcolorfield(L, "blue");
    } else {
        error(L, "invalid value for 'background'");
    }
}