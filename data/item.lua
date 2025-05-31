
local Fovy = require "fovy"
local Global = require "global"

Global.ItemList = {}

local Item = {}

Item.type = {
	BLANK = 1,
	FOOD = 2,
}

Item.rarity = {
	COMMON = 1,
	RARE = 2,
	EPIC = 3,
	GOLD = 4,
	MYTHICAL = 5,
}

function Item:getDefaultComponents(type)
	local components = {
		rarity = Item.rarity.COMMON
	}

	local c = {}

	if type == Item.type.BLANK then
		c = {}
	elseif type == Item.type.FOOD then
		c = {
			nutrition = 1,
		}
	end
	
	return c
end

--- Registers an item to the item database
--- @param name string
--- @param type integer
--- @param components table
function Item:register(name, type, components)
	local item = {}
	item.name = name
	item.type = type
	item.components = Item:getDefaultComponents(type)

	item.components = Fovy:merge(item.components, components or {})

	Global.ItemList[name] = item
end

return Item

