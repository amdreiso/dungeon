
local Global = require "global"
local Anim8 = require "libs.anim8"

local Fovy = {}

function Fovy:rgb(r, g, b)
	local val = {}
	val.r = r
	val.g = g
	val.b = b

	return val
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
	if not Global.debug then return end

	love.graphics.setColor(1, 1, 1)
	love.graphics.print("kizza", 0, 0)
	love.graphics.print("made by amdrei", 0, 12)
end

function Fovy:instanceAdd(obj, components) 
	local o = obj

	for key, val in pairs(components or {}) do
		o[key] = val
	end

	table.insert(Global.instances, o)
end

function Fovy:instanceFind(name)
	for _, obj in ipairs(Global.instances) do
		if name == obj.name then
			return obj
		end
	end
end

function Fovy:instanceFindAll(name)
	local i = {}

	for _, obj in ipairs(Global.instances) do
		if name == obj.name then
			table.insert(i, obj)
		end
	end

	return i
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

function Fovy:rgba(r, g, b, a)
	return {r = r, g = g, b = b, a = a or 1.0}
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

function Fovy:createInstance(obj)
	table.insert(Global.instances, obj)
end

return Fovy

