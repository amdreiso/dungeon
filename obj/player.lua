
local Fovy = require "fovy"
local Object = require "object"
local Global = require "global"
local Particle = require "obj.particle"

local Player = {
	x = 0,
	y = 0,
	hitbox = Fovy:dim(10, 10),
	speed = 0,
	speedTo = 0,
	direction = 0,
	directionTo = 0,
	acceleration = 0.1,
	turnSpeed = 0.05,
	force = Fovy:vec2(0, 0),
	dash = false,
	dashTime = 0,

	health = 0,
	alive = true,

	color = Fovy:rgb(1.00, 1.00, 1.00),
}

function Player:new()
	local player = {}
	player.destroy = function(self)
		print("Player destroyed")
		self.isDestroyed = true
	end

	setmetatable(player, self)
	self.__index = self
	return player
end

function Player:update()
	self:movement()
end

function Player:movement()
	local isMoving = (self.speedTo ~= 0)

	if love.keyboard.isDown("w") then
		self.speedTo = 2
	else
		self.speedTo = 0
	end

	if isMoving then
		if love.keyboard.isDown("d") then
			self.directionTo = self.directionTo + self.turnSpeed
		elseif love.keyboard.isDown("a") then
			self.directionTo = self.directionTo - self.turnSpeed
		end
	end

	if love.keyboard.isDown("space") then
		self.dash = true

		for i = 1, 10 do
			local particle = Particle:new()
			particle.x = self.x
			particle.y = self.y
			particle.vx = math.random(-10, 10)
			particle.vy = math.random(-10, 10)
			particle.lifetime = math.random(10, 20)
			particle.scale = math.random(1, 5)
			particle.speed = math.random(1.00, 3.00)
			particle.color = Fovy:rgb(math.random(0.70, 1.00), 0, 0)
			table.insert(Global.Instances, particle)
		end
	end

	self.force.x = Fovy:lerp(self.force.x, 0, 0.1)
	self.force.y = Fovy:lerp(self.force.y, 0, 0.1)

	self.direction = Fovy:lerp(self.direction, self.directionTo, 0.1)
	self.speed = Fovy:lerp(self.speed, self.speedTo, 0.1)

	self.x = self.x + self.force.x + self.speed * math.cos(self.direction)
	self.y = self.y + self.force.y + self.speed * math.sin(self.direction)
end

function Player:draw()
	love.graphics.setColor(self.color.r, self.color.g, self.color.b, 1)
	love.graphics.rectangle("fill", self.x, self.y, self.hitbox.width, self.hitbox.height)
end


return Player

