
local Fovy = require "fovy"
local Global = require "global"

local Bullet = {
	x = 0,
	y = 0,
	direction = 0,
}


function Bullet:new(components)
	local bullet = {}
	bullet.destroy = function(self)
		self.isDestroyed = true
	end

	bullet = Fovy:merge(bullet, components or {})

	setmetatable(bullet, self)
	self.__index = self
	return bullet
end

function Bullet:update(dt)
	self.x, self.y = Fovy:moveTowards(self.x, self.y, self.direction, 1)
end

function Bullet:draw()
	love.graphics.rectangle("fill", self.x, self.y, 1, 1)
end

function Bullet:drawGUI()
end


Global.Instances["bullet"] = Bullet

return Bullet

