
local Fovy = require "fovy"
local Global = require "global"

Global.TileList = {}

local Tile = {}

love.graphics.setDefaultFilter("nearest", "nearest")

function Tile:register(name, id, sprite)
	local tile = {}

	tile.name = name
	tile.id = id
	tile.sprite = love.graphics.newImage( sprite )

	Global.TileList[id] = tile
end

return Tile

