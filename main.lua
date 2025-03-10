
local Fovy = require "fovy"
local Object = require "object"
local Global = require "global"
local Level = require "level"
local Window = require "window"
local Player = require "obj.player"
local Camera = require "obj.camera"
local Particle = require "obj.particle"



local player = Player:new() 
local camera = Camera:new()
camera:setTarget(player)

Fovy:instanceAdd(player)
Fovy:instanceAdd(camera)


function love.conf(t)
	t.console = true
end

function love.load()
	Window:setup()
	Level:create()
end

function love.update(dt)
	love.math.setRandomSeed(os.time())
	Level:update(dt)

	for _, instance in ipairs(Global.Instances) do
		instance:update(dt)
		if instance.isDestroyed then
			table.remove(Global.Instances, _)
		end
	end
end

function love.draw()
	love.graphics.clear(0.4, 0.1, 0.4)

	camera:set()

	for _, instance in ipairs(Global.Instances) do
	  instance:draw()
	end

	Level:draw()

	camera:unset()

	for _, instance in ipairs(Global.Instances) do
	 	instance:drawGUI()
	end

	Fovy:drawDebug()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end

	if key == "r" then
		love.event.quit("restart")
	end
end


