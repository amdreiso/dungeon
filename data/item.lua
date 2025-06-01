
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
function Item:register(name, sprite, type, components)
	local item = {}
	item.name = name
	item.sprite = 0
	item.type = type
	item.components = Item:getDefaultComponents(type)

	item.components = Fovy:merge(item.components, components or {})

	if sprite ~= 0 then
		item.sprite = love.graphics.newImage("assets/img/items/" .. sprite)
    item.sprite:setFilter("nearest", "nearest")
	end

	local id = #Global.ItemList + 1
	print(id)
	Global.ItemList[id] = item
end

function Item:getType(type)
	local t = ""

	if type == Item.type.BLANK then t = "BLANK" end 
	if type == Item.type.FOOD then t = "FOOD" end 
	
	return t
end

return Item

