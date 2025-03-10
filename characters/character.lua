
local Global = require "global"

local Character = {}
Global.CharacterList = {}

function Character:new()
	local character = {}

	setmetatable(character, self)
	self.__index = self
	return character
end



return Character

