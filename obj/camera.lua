
local Fovy = require "fovy"
local Global = require "global"

local Camera = {
	id = "camera",
	pos = Fovy:vec2(0, 0),
	zoom = 4,
	target = nil,
	shakeValue = 0.00,
}

Camera.dim = Fovy:dim(
	love.graphics.getWidth() / Camera.zoom,
	love.graphics.getHeight() / Camera.zoom
)

function Camera:new(components)
	local camera = {}
	camera.destroy = function(self)
		print("Camera destroyed")
		self.isDestroyed = true
	end

	camera = Fovy:merge(camera, components or {})

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
	self.dim = Fovy:dim(
		love.graphics.getWidth() / self.zoom,
		love.graphics.getHeight() / self.zoom
	)

	local w = self.dim.width
	local h = self.dim.height

	if self.target then
		self.pos.x = Fovy:lerp(self.pos.x, (self.target.pos.x - w / 2) + math.random(-self.shakeValue, self.shakeValue), 0.1)
		self.pos.y = Fovy:lerp(self.pos.y, (self.target.pos.y - h / 2) + math.random(-self.shakeValue, self.shakeValue), 0.1)
	end

	-- Mouse Tile Position
	local mx, my = love.mouse.getPosition()
	Global.MousePos = Fovy:vec2(
		self.pos.x + mx / self.zoom, self.pos.y + my / self.zoom
	)
end

function Camera:setPosition(x, y)
	local w = self.dim.width
	local h = self.dim.height

	self.pos.x = x - w / 2
	self.pos.y = y - h / 2
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

Global.Instances["camera"] = Camera

return Camera

