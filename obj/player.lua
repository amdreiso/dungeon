local Fovy = require("libs.fovy")
local Global = require("global")

local Player = {
	pos = Fovy:vec2(200, 200),
	hsp = 0,
	vsp = 0,
	speed = 2,

	hitbox = Fovy:dim(20, 20),
}

function Player:new()
	local player = {}
	player.destroy = function(self)
		self.isDestroyed = true
	end

	setmetatable(player, self)
	self.__index = self
	return player
end

function Player:movement(dt)
	self.hsp = 0
	self.vsp = 0

	if love.keyboard.isDown("w") then
		self.vsp = self.vsp - self.speed
	end

	if love.keyboard.isDown("s") then
		self.vsp = self.vsp + self.speed
	end

	if love.keyboard.isDown("a") then
		self.hsp = self.hsp - self.speed
	end

	if love.keyboard.isDown("d") then
		self.hsp = self.hsp + self.speed
	end

	if self.hsp ~= 0 and self.vsp ~= 0 then
		self.hsp = self.hsp * 0.7071
		self.vsp = self.vsp * 0.7071
	end

	self.pos.x = self.pos.x + self.hsp
	self.pos.y = self.pos.y + self.vsp
end

function Player:update(dt)
	self:movement(dt)
end

function Player:draw()
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.hitbox.width, self.hitbox.height)
end

return Player
