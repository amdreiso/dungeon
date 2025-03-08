
local Fovy = require "fovy"
local Object = require "object"

local Camera = {
	x = 0,
	y = 0,
	zoom = 2,
	target = nil,
	shakeValue = 0.00,
}

function Camera:new()
	local camera = {}
	camera.destroy = function(self)
		print("Camera destroyed")
		self.isDestroyed = true
	end

	setmetatable(camera, self)
	self.__index = self
	return camera
end

function Camera:set()
	love.graphics.push()
	love.graphics.scale(self.zoom)
	love.graphics.translate(-(self.x), -(self.y))
end

function Camera:unset()
	love.graphics.pop()
end

function Camera:setTarget(target)
	self.target = target
end

function Camera:update()
	if self.target then
		local w, h = love.graphics.getWidth() / self.zoom, love.graphics.getHeight() / self.zoom

		self.x = (self.target.x - w / 2) + math.random(-self.shakeValue, self.shakeValue)
		self.y = (self.target.y - h / 2) + math.random(-self.shakeValue, self.shakeValue)
	end
end

function Camera:setPosition(x, y)
	self.x = x
	self.y = y
end

function Camera:shake(shakeValue)
	self.shakeValue = shakeValue
end

return Camera

