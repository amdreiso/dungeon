
local Fovy = require "fovy"
local Global require "global"
local Item = require "data.item"

Item:register("pumpkin", Item.type.FOOD, {nutrition=30})

Item:register("cum flavored monster", Item.type.FOOD, {
	rarity = Item.rarity.MYTHICAL, 
	nutrition = 999
})

