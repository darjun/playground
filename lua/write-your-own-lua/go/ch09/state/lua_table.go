package state

import (
	"math"

	"github.com/darjun/luago/ch09/number"
)

type luaTable struct {
	arr  []luaValue
	hash map[luaValue]luaValue
}

func newLuaTable(nArr, nRec int) *luaTable {
	t := &luaTable{}
	if nArr > 0 {
		t.arr = make([]luaValue, 0, nArr)
	}
	if nRec > 0 {
		t.hash = make(map[luaValue]luaValue, nRec)
	}
	return t
}

func (self *luaTable) get(key luaValue) luaValue {
	key = floatToInteger(key)
	if idx, ok := key.(int64); ok {
		if idx >= 1 && idx <= int64(len(self.arr)) {
			return self.arr[idx-1]
		}
	}
	return self.hash[key]
}

func floatToInteger(key luaValue) luaValue {
	if f, ok := key.(float64); ok {
		if i, ok := number.FloatToInteger(f); ok {
			return i
		}
	}

	return key
}

func (self *luaTable) put(key, val luaValue) {
	if key == nil {
		panic("table index is nil!")
	}

	if f, ok := key.(float64); ok && math.IsNaN(f) {
		panic("table index is NaN")
	}
	key = floatToInteger(key)
	if idx, ok := key.(int64); ok && idx >= 1 {
		arrLen := int64(len(self.arr))
		if idx <= arrLen {
			self.arr[idx-1] = val
			if idx == arrLen && val == nil {
				self.shrinkArray()
			}
			return
		}
		if idx == arrLen+1 {
			delete(self.hash, key)
			if val != nil {
				self.arr = append(self.arr, val)
				self.expandArray()
			}
			return
		}
	}
	if val != nil {
		if self.hash == nil {
			self.hash = make(map[luaValue]luaValue, 8)
		}
		self.hash[key] = val
	} else {
		delete(self.hash, key)
	}
}

func (self *luaTable) shrinkArray() {
	for i := len(self.arr) - 1; i >= 0; i-- {
		if self.arr[i] == nil {
			self.arr = self.arr[:i]
		}
	}
}

func (self *luaTable) expandArray() {
	for idx := int64(len(self.arr)) + 1; ; idx++ {
		if val, found := self.hash[idx]; found {
			delete(self.hash, idx)
			self.arr = append(self.arr, val)
		} else {
			break
		}
	}
}

func (self *luaTable) len() int {
	return len(self.arr)
}
