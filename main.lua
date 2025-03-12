
require "data.enemies"

local Fovy = require "fovy"
local Object = require "object"
local Global = require "global"
local Level = require "level"
local Window = require "window"
local Player = require "obj.player"
local Camera = require "obj.camera"
local Particle = require "obj.particle"
local Enemy = require "obj.enemy"


local player = Player:new() 
local camera = Camera:new()
local enemy = Enemy:new(0)
camera:setTarget(player)

Fovy:instanceAdd(player)
Fovy:instanceAdd(camera)
Fovy:instanceAdd(enemy, {pos = Fovy:vec2(100, 100),})

Fovy:printTable(Global.Instances, 2)

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
	love.graphics.clear(0.4, 0.4, 0.4)

	camera:set()

	for _, instance in ipairs(Global.Instances) do
	  instance:draw()

		if instance.hitbox ~= nil then
			love.graphics.setColor(0.5, 0.5, 1.0)
			love.graphics.rectangle(
				"line", 
				instance.pos.x - instance.hitbox.width / 2, 
				instance.pos.y - instance.hitbox.height / 2, 
				instance.hitbox.width, 
				instance.hitbox.height)
		end

		love.graphics.setColor(1, 1, 1)
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

	if key == "f2" then
		local filename = os.date("screenshot_%Y-%m-%d_%H-%M-%S.png")
		love.graphics.captureScreenshot(filename)
	end
end


