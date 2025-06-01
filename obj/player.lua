
local Fovy = require "fovy"
local Global = require "global"
local Level = require "level"
local Particle = require "obj.particle"
local Anim8 = require "libs.anim8"
local Item = require "data.item"

love.graphics.setDefaultFilter("nearest", "nearest")

local Player = {
	id = "player",
	characterID = 0,

	pos = Fovy:vec2(0, 0),
	hsp = 0,
	vsp = 0,
	hitbox = Fovy:dim(10, 10),
	speed = 1,
	
	force = Fovy:vec2(0, 0),
	dash = false,
	dashTime = 0,

	range = 10,

	onCar = false,
	car = {
		speed = 0,
		speedTo = 0,
		direction = 0,
		directionTo = 0,
		acceleration = 0.1,
		turnSpeed = 0.05,
	},

	health = 0,
	alive = true,

	color = Fovy:rgb(1.00, 1.00, 1.00),

	sprite = {
		idle = Fovy:newSprite("assets/img/characters/default/default_idle.png", 16, 16, "1-5", 1, 0.5),
		walk = Fovy:newSprite("assets/img/characters/default/default_walk.png", 16, 16, "1-2", 1, 0.17),
	},

	spriteIndex = nil,

	scale = 1,
	xscale = 1,
	yscale = 1,

	hands = {
		"pumpkin",
		0,
	},
	handIndex = 1,
}

Player.spriteIndex = Player.sprite.idle

function Player:new(components)
	local player = {}
	player.destroy = function(self)
		print("Player destroyed")
		self.isDestroyed = true
	end

	player = Fovy:merge(player, components or {})

	setmetatable(player, self)
	self.__index = self
	return player
end

-- Sets the player's character
function Player:setCharacter(characterID)
	self.characterID = characterID
end

-- Walking movement
function Player:walkMovement()
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

	-- Normalize diagonal movement
	-- thanks copilot
	if self.hsp ~= 0 and self.vsp ~= 0 then
		self.hsp = self.hsp * 0.7071
		self.vsp = self.vsp * 0.7071
	end

	self.pos.x = self.pos.x + self.hsp
	self.pos.y = self.pos.y + self.vsp
end

-- Car movement
function Player:carMovement()
	local isMoving = (self.speedTo ~= 0)
	local car = self.car

	if love.keyboard.isDown("w") then
		car.speedTo = 2
	else
		car.speedTo = 0
	end

	if isMoving then
		if love.keyboard.isDown("d") then
			car.directionTo = car.directionTo + car.turnSpeed
		elseif love.keyboard.isDown("a") then
			car.directionTo = car.directionTo - car.turnSpeed
		end
	end

	self.force.x = Fovy:lerp(self.force.x, 0, 0.1)
	self.force.y = Fovy:lerp(self.force.y, 0, 0.1)

	car.direction = Fovy:lerp(car.direction, car.directionTo, 0.1)
	car.speed = Fovy:lerp(car.speed, car.speedTo, 0.1)

	self.pos.x = self.pos.x + self.force.x + car.speed * math.cos(car.direction)
	self.pos.y = self.pos.y + self.force.y + car.speed * math.sin(car.direction)
end

-- Actual movement
function Player:movement()
	if self.onCar then
		self:carMovement()
	else
		self:walkMovement()
	end

	self.pos.x = Fovy:clamp(self.pos.x, self.hitbox.width/2, Level.size.width - self.hitbox.width/2)
	self.pos.y = Fovy:clamp(self.pos.y, self.hitbox.height/2, Level.size.height - self.hitbox.height/2)

	if love.keyboard.isDown("space") then
		for i = 1, 100 do
			local particle = Particle:new()
			particle.x = self.pos.x
			particle.y = self.pos.y
			particle.vx = math.random(-10, 10)
			particle.vy = math.random(-10, 10)
			particle.lifetime = math.random(10, 20)
			particle.scale = math.random(1, 5)
			particle.speed = math.random(1.00, 3.00)
			particle.color = Fovy:rgb(math.random(0.70, 1.00), 0, 0)
			table.insert(Level.instances, particle)
		end
	end
end

function Player:drawAnimation()
	self.spriteIndex = self.sprite.idle

	if self.hsp ~= 0 or self.vsp ~= 0 then
		self.spriteIndex = self.sprite.walk
	end

	if self.hsp ~= 0 then 
		self.xscale = Fovy:sign(self.hsp)
	end

	love.graphics.setColor(1, 1, 1)

	self.spriteIndex.anim:draw(
		self.spriteIndex.image,
		self.pos.x, self.pos.y,
		0,
		self.scale * self.xscale, self.scale * self.yscale,
		self.spriteIndex.image:getWidth() / (2 * self.spriteIndex.grid.width),
		self.spriteIndex.image:getHeight() / 2
	)
end

function Player:getRange()
	return self.range
end

function Player:getHand()
	return self.hands[self.handIndex]
end

function Player:setHand(index, value)
	self.hands[index] = value
end

function Player:update(dt)
	self:movement()	

	-- Draw
	self.spriteIndex.anim:update(dt)
end

function Player:draw()
	self:drawAnimation()
end

function Player:drawGUI()
	local hand = self:getHand()
	local item = Global.ItemList[hand]
	love.graphics.draw(item.sprite, 100, 100, 0, 5, 5)
end

Global.Instances["player"] = Player

return Player


