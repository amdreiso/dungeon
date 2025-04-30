local Fovy = require "libs.fovy"
local Global = require "global"
local Tile = require "obj.tile"

local Level = {}

function Level:cell(id, pos)
  local cell = {}

  cell.id = id
	cell.pos = pos

  return cell
end

function Level:new()
  local level = {}

  local size = 7

  for i = -size, size do
    for j = -size, size do
			local tileID = math.random(1, 2)
			local pos = Fovy:vec2(i, j)
			local cell = Level:cell(tileID, pos) 

			table.insert(level, cell)
    end
  end

  return level
end

function Level:draw(level)

	for i=1, #level do
		local cell = level[i]
		local tile = Tile:get(cell.id)

		love.graphics.setColor(tile.color.r, tile.color.g, tile.color.b)

		love.graphics.rectangle(
			"fill", 
			cell.pos.x * Global.cellSize,
			cell.pos.y * Global.cellSize,
			Global.cellSize, Global.cellSize
		)

		love.graphics.setColor(1, 1, 1)
	end

end

return Level
