
local Fovy = require "fovy"
local Object = require "object"
local Player = require "obj.player"
local Camera = require "obj.camera"
local Particle = require "obj.particle"
local Global = require "global"


local player = Player:new() 
local camera = Camera:new()
camera:setTarget(player)

local dummy = Object:new()
dummy:implement {
	x = 90,
	y = 190,
}


function love.conf(t)
	t.console = true
end

function love.load()
end

function love.update(dt)
	player:update()
	camera:update()

	for _, instance in ipairs(Global.Instances) do
		instance:update(dt)
		if instance.isDestroyed then
			table.remove(Global.Instances, _)
		end
	end
end

function love.draw()
	camera:set()

	player:draw()
	love.graphics.rectangle("fill", dummy.x, dummy.y, 10, 10)

	for _, instance in ipairs(Global.Instances) do
		instance:draw()
	end

	camera:unset()
end

