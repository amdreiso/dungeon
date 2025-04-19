
local Fovy = require "libs.fovy"
local Global = require "global"

local Level = {
}

function Level:new(id, name, layout)
	local level = {}

	level.name = name
	level.layout = layout

	Global.levels[id] = level
end

function Level:layout(dimension) 
	local layout = {}

	for i=1, dimension.height do
		layout[i] = {}

		for j=1, dimension.width do
			layout[i][j] = Level:cell(-1)
		end
	end

	return layout
end

function Level:cell(id, components)
	local cell = {
		id = id,
		solid = false,
		portal = false,
		portalOutput = 0,
	}

	for key, val in pairs(components or {}) do
		cell[key] = val
	end
	
	return cell
end

return Level

