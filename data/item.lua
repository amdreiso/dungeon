
local Global = require "global"
local Fovy = require "libs.fovy"

Global.itemData = {}

local Item = {}

function Item:getDefaultComponents()
	return {
		rarity = "common",
	}
end

function Item:createItem(name, id, components)
	local item = {}
	item.name = name
	item.components = Item:getDefaultComponents()

	Fovy:merge(item.components, components)

	Global.itemData[id] = item
end

return Item

