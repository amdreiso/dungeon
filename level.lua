
local Global = require "global"
local Fovy = require "fovy"

local Level = {
	size = Fovy:dim(500, 500),

	receivePoint = {
		pos = Fovy:vec2(0, 0),
		hitbox = Fovy:dim(5, 5),
		hasPizza = true,
	},

	deliverPoint = {
		pos = Fovy:vec2(0, 0),
		hitbox = Fovy:dim(5, 5),
	}
}

function Level:setPoints()
	self.receivePoint.pos.x = love.math.random(0, self.size.width)
	self.receivePoint.pos.y = love.math.random(0, self.size.height)

	self.deliverPoint.pos.x = love.math.random(0, self.size.width)
	self.deliverPoint.pos.y = love.math.random(0, self.size.height)

	local minDistance = self.size.width / 1.5
	local dis = (Fovy:distance2D(
		self.receivePoint.pos.x, 
		self.receivePoint.pos.y, 
		self.deliverPoint.pos.x, 
		self.deliverPoint.pos.y)) 

	--print("Distance: " .. dis, "Minimum Distance" .. minDistance)

	if dis < minDistance then
		--print("REJECTED")
		self:setPoints()
	end
end

function Level:create() 
	self:setPoints()
end

function Level:update(dt)
end

function Level:draw()
	love.graphics.setColor(1, 1, 0)
	love.graphics.circle("fill", self.receivePoint.pos.x, self.receivePoint.pos.y, 5)

	love.graphics.setColor(1, 0, 1)
	love.graphics.circle("fill", self.deliverPoint.pos.x, self.deliverPoint.pos.y, 5)

	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("line", 0, 0, self.size.width, self.size.height)
end

return Level

