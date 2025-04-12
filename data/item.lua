
local Global = require "global"
local Fovy = require "libs.fovy"

Global.itemData = {}

local Item = {}

function Item:createItem(name, id, components)
	local item = {}
	item.name = name

	Fovy:merge(item, components)

	Global.itemData[id] = item
end

return Item

