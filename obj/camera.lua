
local Fovy = require "libs.fovy"
local Global = require "global"
local Settings = require "settings"

local Camera = {
	name = "Camera",
	pos = Fovy:vec2(0, 0),
	zoom = 1,
	target = nil,
	shakeValue = 0.00,
	shakePower = 1.00,
	moveSpeed = 0.25,
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
	-- Shake 
	self.shakeValue = math.max(0, self.shakeValue - 1)

	if self.target then
		local w, h = love.graphics.getWidth() / self.zoom, love.graphics.getHeight() / self.zoom
		local spd = self.moveSpeed

		local shake = (self.shakeValue ^ self.shakePower) * Settings.graphics.cameraShakeIntensity
		local shakeX = math.random(-shake, shake)
		local shakeY = math.random(-shake, shake)

		self.pos.x = Fovy:lerp(self.pos.x, (self.target.pos.x - w / 2) + shakeX, spd)
		self.pos.y = Fovy:lerp(self.pos.y, (self.target.pos.y - h / 2) + shakeY, spd)
	end
end

function Camera:setPosition(x, y)
	self.pos.x = x
	self.pos.y = y
end

function Camera:shake(shakeValue, shakePower)
	self.shakeValue = shakeValue
	self.shakePower = shakePower or 1.00
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

