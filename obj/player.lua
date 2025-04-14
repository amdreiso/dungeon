

local Fovy = require "libs.fovy"
local Global = require "global"

local Player = {
	pos = Fovy:vec2(200, 200),
	hsp = 0,
	vsp = 0,

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

function Player:update(dt)
end

function Player:draw()
	love.graphics.rectangle(
		"fill",
		self.pos.x, self.pos.y,
		self.hitbox.width, self.hitbox.height
	)
end

return Player


