
local Fovy = require "fovy"
local Global = require "global"

local Enclosure = {
	pos = Fovy:vec2(0, 0),
	dim = Fovy:dim(32, 32),
	color = Fovy:rgb(
		math.random(), math.random(), math.random()
	)
}

function Enclosure:new(components)
	local enclosure = {}
	enclosure.destroy = function(self)
		self.isDestroyed = true
	end

	enclosure = Fovy:merge(enclosure, components or {})
	
	setmetatable(enclosure, self)
	self.__index = self
	return enclosure
end

function Enclosure:update(dt)
	Fovy:printTable(self.color)
end

function Enclosure:draw()
	love.graphics.setColor(self.color.red, self.color.green, self.color.blue)

	love.graphics.rectangle("line", self.pos.x, self.pos.y, self.dim.width, self.dim.height)

	love.graphics.setColor(1, 1, 1)
end

function Enclosure:drawGUI()
end

Global.Instances["enclosure"] = Enclosure

return Enclosure

