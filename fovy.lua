
local Global = require "global"
local Anim8 = require "libs.anim8"

local Fovy = {}

function Fovy:direction(x1, y1, x2, y2)
  return math.atan2(y2 - y1, x2 - x1)
end

function Fovy:moveTowards(x, y, direction_deg, speed)
  local rad = math.rad(direction_deg)
  local dx = math.cos(rad) * speed
  local dy = math.sin(rad) * speed
  return x + dx, y + dy
end

function Fovy:pointDistance(x1, y1, x2, y2)
	return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function Fovy:merge(a, b)
  local result = {}
  for k, v in pairs(a) do result[k] = v end
  for k, v in pairs(b) do result[k] = v end
  return result
end

function Fovy:clamp(val, min, max)
	if val < min then
		return min
	elseif val > max then
		return max
	else
		return val
	end
end	

function Fovy:sign(val)
	if val > 0 then
		return 1
	elseif val < 0 then
		return -1
	else
		return 0
	end
end

function Fovy:drawDebug()
	if not Global.Debug then return end

	love.graphics.setColor(1, 1, 1)
	self:text("gamble game", 0, 0, 1)
	self:text("made by amdrei", 0, 12, 1)
end

function Fovy:text(str, x, y, offset)
	love.graphics.setColor(0, 0, 0)
	love.graphics.print(str, x+offset, y+offset)
	love.graphics.setColor(1, 1, 1)
	love.graphics.print(str, x, y)
end

function Fovy:newSprite(imageURL, width, height, gridRow, gridColumn, speed)
	local sprite = {}

	sprite.image = love.graphics.newImage(imageURL)
	sprite.grid = Anim8.newGrid(width, height, sprite.image:getWidth(), sprite.image:getHeight())
	sprite.anim = Anim8.newAnimation(sprite.grid(gridRow, gridColumn), speed)

	return sprite
end

function Fovy:distance2D(x1, y1, x2, y2)
	return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

function Fovy:colliding(a, b)
	if a.pos.x < b.pos.x + b.hitbox.width and
		a.pos.x + a.hitbox.width > b.pos.x and
		a.pos.y < b.pos.y + b.hitbox.height and
		a.pos.y + a.hitbox.height > b.pos.y then
		return true
	end
end

function Fovy:rgb(r, g, b)
	return {red = r, green = g, blue = b}
end

function Fovy:printTable(t, indent)
	indent = indent or 0

	for k, v in pairs(t) do
		local prefix = string.rep("  ", indent)

		if type(v) == "table" then
			print(prefix .. k .. ": {")
			Fovy:printTable(v, indent + 1)
			print(prefix .. "}")
		else
			print(prefix .. k .. ": " .. tostring(v))
		end
	end
end

function Fovy:vec2(x, y)
	return {x = x, y = y}
end

function Fovy:vec3(x, y, z)
	return {x = x, y = y, z = z}
end

function Fovy:dim(width, height)
	return {width = width, height = height}
end

function Fovy:lerp(a, b, t)
	return a + (b - a) * t
end

return Fovy

