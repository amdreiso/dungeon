
local Global = require "global"

local Fovy = {}

function Fovy:rgb(r, g, b)
	return {r = r, g = g, b = b}
end

function Fovy:printTable(t)
	for k, v in pairs(t) do
		print(k, v)
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
	table.insert(Global.Instances, obj)
end

return Fovy

