
require "data.enemies"

require "lists.init"
require "obj.init"

-- require init and whatever to load every data files

local Fovy = require "fovy"
local Global = require "global"
local Level = require "level"
local Window = require "window"

local camera

function love.conf(t)
t.console = true
end

function love.load()
math.randomseed(os.time())

love.graphics.setDefaultFilter("nearest", "nearest")

Window:setup()
Level:create()

camera = Level:instanceFind("camera")
end

function love.update(dt)
love.math.setRandomSeed(os.time())
Level:update(dt)

for _, instance in ipairs(Level.instances) do
	instance:update(dt)
	if instance.isDestroyed then
		table.remove(Level.instances, _)
	end
end
end

function love.draw()
love.graphics.clear(0, 0, 0)

camera:set()

Level:draw()

for _, instance in ipairs(Level.instances) do
	instance:draw()

	if instance.hitbox ~= nil and Global.Debug then
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

camera:unset()

for _, instance in ipairs(Level.instances) do
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

  if key == "f3" then
    Global.Debug = not Global.Debug
  end
end

