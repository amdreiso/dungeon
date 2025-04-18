
local Fovy = require "libs.fovy"
local Global = require "global"

local Camera = {
	pos = Fovy:vec2(0, 0),
	zoom = 2,
	target = nil,
	shakeValue = 0.00,
	moveSpeed = 0.25,

	hitbox = Fovy:dim(4, 4),
}

function Camera:new()
	local camera = {}

	setmetatable(camera, self)
	self.__index = self

	return camera
end

function Camera:set()
	love.graphics.push()
	love.graphics.scale(self.zoom)
	love.graphics.translate(-(self.pos.x), -(self.pos.y))
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
		local spd = self.moveSpeed

		self.pos.x = Fovy:lerp(self.pos.x, (self.target.pos.x - w / 2) + math.random(-self.shakeValue, self.shakeValue), spd)
		self.pos.y = Fovy:lerp(self.pos.y, (self.target.pos.y - h / 2) + math.random(-self.shakeValue, self.shakeValue), spd)
	end
end

function Camera:setPosition(x, y)
	self.pos.x = x
	self.pos.y = y
end

function Camera:shake(shakeValue)
	self.shakeValue = shakeValue
end

function Camera:draw()
end

function Camera:drawGUI()
end

function love.wheelmoved(x, y)
	if y > 0 then
		Camera.zoom = Camera.zoom + 0.1
	elseif y < 0 then
		Camera.zoom = Camera.zoom - 0.1
	end
end



return Camera

