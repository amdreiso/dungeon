
local Fovy = require "fovy"
local Object = require "object"
local Global = require "global"
local Level = require "level"
local Particle = require "obj.particle"
local Anim8 = require "lib.anim8"

love.graphics.setDefaultFilter("nearest", "nearest")

local Player = {
	characterID = 0,

	pos = Fovy:vec2(0, 0),
	hsp = 0,
	vsp = 0,
	hitbox = Fovy:dim(10, 10),
	speed = 1,
	
	force = Fovy:vec2(0, 0),
	dash = false,
	dashTime = 0,

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

	hasPizza = false,
	pizzaIsCold = false,
	pizzaTimer = 100,

	color = Fovy:rgb(1.00, 1.00, 1.00),

	sprite = {
		idle = Fovy:newSprite("assets/img/characters/default/default_idle.png", 9, 11, "1-5", 1, 0.5),
		walk = Fovy:newSprite("assets/img/characters/default/default_walk.png", 9, 11, "1-2", 1, 0.17),
	},

	spriteIndex = nil,

	scale = 1,
	xscale = 1,
	yscale = 1,
}

Player.spriteIndex = Player.sprite.idle

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

function Player:setCharacter(characterID)
	self.characterID = characterID
end

function Player:setPizza(val)
	self.hasPizza = val
	self.pizzaTimer = 100
	self.pizzaIsCold = false
end

function Player:pizzaLogic()
	if not self.hasPizza then return false end

	self.pizzaTimer = self.pizzaTimer - 0.05
	if self.pizzaTimer <= 0 then
		self.hasPizza = false
		self.pizzaTimer = 100
		self.pizzaIsCold = true

		-- Game Over logic
	end
end

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

function Player:movement()
	if self.onCar then
		self:carMovement()
	else
		self:walkMovement()
	end

	if love.keyboard.isDown("space") then
		for i = 1, 10 do
			local particle = Particle:new()
			particle.x = self.pos.x
			particle.y = self.pos.y
			particle.vx = math.random(-10, 10)
			particle.vy = math.random(-10, 10)
			particle.lifetime = math.random(10, 20)
			particle.scale = math.random(1, 5)
			particle.speed = math.random(1.00, 3.00)
			particle.color = Fovy:rgb(math.random(0.70, 1.00), 0, 0)
			table.insert(Global.Instances, particle)
		end
	end
end

function Player:getPizza()
	if not Level.receivePoint.hasPizza then
		return false
	end

	if Fovy:colliding(self, Level.receivePoint) then
		print("GOT PIZZA")
		self:setPizza(true)
		Level.receivePoint.hasPizza = false
	end
end

function Player:deliverPizza()
	if not self.hasPizza then
		return false
	end

	if Fovy:colliding(self, Level.deliverPoint) then
		print("DELIVERED PIZZA")
		self:setPizza(false)
		Level.receivePoint.hasPizza = true
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

	self.spriteIndex.anim:draw(
		self.spriteIndex.image,
		self.pos.x, self.pos.y,
		0,
		self.scale * self.xscale, self.scale * self.yscale,
		self.spriteIndex.image:getWidth() / (2 * self.spriteIndex.grid.width),
		self.spriteIndex.image:getHeight() / 2
	)
end

function Player:update(dt)
	self:movement()
	self:pizzaLogic()

	-- Draw
	self.spriteIndex.anim:update(dt)
	
	-- PIZZA
	self:getPizza()
	self:deliverPizza()
end

function Player:draw()
	self:drawAnimation()

	if self.hasPizza then
		love.graphics.setColor(0.4, 0.3, 1)
		love.graphics.circle("fill", self.pos.x + 5, self.pos.y - 5, 5)
	end
end

function Player:drawGUI()
	local w, h = love.graphics.getWidth(), love.graphics.getHeight()
	local multiplier = 3
	local t = self.pizzaTimer / 2 * multiplier
	local maxT = 100 / 2 * multiplier
	
	if self.hasPizza then
		love.graphics.setColor(0.4, 0.3, 1)
		love.graphics.rectangle("fill", 0, h/2 - t, 30, t + t)
	end

	love.graphics.setColor(0.4, 0.3, 1)
	love.graphics.rectangle("line", 0, h/2 - maxT, 30, maxT + maxT)
end

return Player

