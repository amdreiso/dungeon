
local Fovy = require "fovy"
local Global = require "global"

local Enemy = {
	id = "enemy",
	kind = 0,

	pos = Fovy:vec2(0, 0),
	hsp = 0,
	vsp = 0,
	hitbox = Fovy:dim(16, 16),
}

function Enemy:set(kind)
	self.kind = kind

	Global.EnemyList[self.kind]:load(self)
end

function Enemy:new(components)
	local enemy = {}
	enemy.destroy = function(self)
		print("Enemy destroyed")
		self.isDestroyed = true
	end

	enemy = Fovy:merge(enemy, components or {})

	setmetatable(enemy, self)
	self.__index = self

	return enemy
end

function Enemy:update(dt)
	self.pos.x = self.pos.x + self.hsp
	self.pos.y = self.pos.y + self.vsp

	Global.EnemyList[self.kind]:update(self, dt)
end

function Enemy:draw()
	love.graphics.setColor(1, 0, 0)
	love.graphics.rectangle(
		"fill", 
		self.pos.x - self.hitbox.width / 2, 
		self.pos.y - self.hitbox.height / 2, 
		self.hitbox.width, 
		self.hitbox.height
	)
end

function Enemy:drawGUI()
end

Global.Instances["enemy"] = Enemy

return Enemy

