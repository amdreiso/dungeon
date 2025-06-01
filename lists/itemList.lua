
local Fovy = require "fovy"
local Global require "global"
local Item = require "data.item"

Item:register("pumpkin", "pumpkin.png", Item.type.FOOD, {nutrition=30})

Item:register("cum flavored monster", 0, Item.type.FOOD, {
	sprite = "assets/img/items/pumpkin.png",
	rarity = Item.rarity.MYTHICAL, 
	nutrition = 999
})

