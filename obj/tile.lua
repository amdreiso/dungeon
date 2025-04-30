
local Fovy = require "libs.fovy"

local Tile = {
	list = {},
}

function Tile:get(id)
	return Tile.list[id]
end

function createTile(id, name, color)
	local tile = {}

	tile.name = name
	tile.color = color

	Tile.list[id] = tile
end

createTile(1, "brick ground", Fovy:rgb(0.11, 0.11, 0.16))
createTile(2, "brick ground", Fovy:rgb(0.21, 0.21, 0.26))

return Tile

