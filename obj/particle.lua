
local Fovy = require "fovy"
local Object = require "object"

local Particle = {
	x = 0,
	y = 0,
	vx = 0,
	vy = 0,
	age = 0,
	lifetime = 1000,
	scale = 1,
	speed = 1,
	color = Fovy:rgb(255, 255, 255),
	dissipate = false,
}

function Particle:new()
	local particle = {}
	self.destroy = function(self)
		self.isDestroyed = true
	end

	setmetatable(particle, self)
	self.__index = self
	return particle
end

function Particle:update(dt)
	self.x = self.x + self.vx * self.speed * dt
	self.y = self.y + self.vy * self.speed * dt
	self.age = self.age + dt

	if self.age >= self.lifetime then
		self:destroy()
	end
end

function Particle:draw()
	local alpha = 1
	if self.dissipate then
		alpha = 1 - self.age / self.lifetime
	end

	love.graphics.setColor(self.color.red, self.color.green, self.color.blue, self.alpha)
	love.graphics.circle("fill", self.x, self.y, self.scale)
end

function Particle:drawGUI()
end

return Particle

