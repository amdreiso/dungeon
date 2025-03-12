
local Fovy = require "fovy"
local Global = require "global"


local Enemy = {
	id = 0,

	pos = Fovy:vec2(0, 0),
	hsp = 0,
	vsp = 0,
	hitbox = Fovy:dim(16, 16),
}

function Enemy:set(id)
	self.id = id

	for key, value in ipairs(Global.EnemyList[id]) do
		self[key] = value
	end
end

function Enemy:new(id)
	local enemy = {}
	enemy.destroy = function(self)
		print("Enemy destroyed")
		self.isDestroyed = true
	end

	self:set(id)

	setmetatable(enemy, self)
	self.__index = self
	return enemy
end

function Enemy:update(dt)
	self.pos.x = self.pos.x + self.hsp
	self.pos.y = self.pos.y + self.vsp
end

function Enemy:draw()
end

function Enemy:drawGUI()
end

return Enemy

