
local Fovy = require("libs.fovy")
local Global = require("global")

local Player = {
	pos = Fovy:vec2(200, 200),
	hsp = 0,
	vsp = 0,
	speed = 2,

	hitbox = Fovy:dim(20, 20),
	onGround = false,
}

function Player:new()
	Player.destroy = function(self)
		self.isDestroyed = true
	end

	setmetatable(Player, self)
	self.__index = self

	return Player
end

function Player:movement(dt)
	self.hsp = 0
	self.vsp = self.vsp + Global.gravity

	if love.keyboard.isDown("a") then
		self.hsp = self.hsp - self.speed
	end

	if love.keyboard.isDown("d") then
		self.hsp = self.hsp + self.speed
	end

	self.pos.x = self.pos.x + self.hsp
	self.pos.y = self.pos.y + self.vsp
end

function Player:update(dt)
	self:movement(dt)
end

function Player:draw()
	--love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.hitbox.width, self.hitbox.height)
end

return Player
