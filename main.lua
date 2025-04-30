local Fovy = require "libs.fovy"
local GUI = require "libs.gui"
local Global = require "global"

require "data.weapon"
require "lists.weapon"

local Player = require "obj.player"
local Camera = require "obj.camera"
local Level = require "obj.level"

local player = Player:new({
  pos = Fovy:vec2(0, 0),
})

local camera = Camera:new()
camera:setTarget(player)

Fovy:instanceAdd(player)
Fovy:instanceAdd(camera)

local level = Level:new()

function love.load()
end

function love.update(dt)
  for _, obj in ipairs(Global.instances) do
    obj:update(dt)
  end

end

function love.draw()
  camera:set()

	Level:draw(level)

  for _, obj in ipairs(Global.instances) do
    obj:draw()
  end

  camera:unset()

  drawDebug()
end

function drawDebug()
  if not Global.debug then return end

  local v = Global.gameInfo.version

  love.graphics.print(Global.gameInfo.name .. " | " .. v[1] .. "." .. v[2] .. " " .. Global.gameInfo.release, 0, 0)
  love.graphics.print("Made by: " .. Global.gameInfo.author, 0, 14)


	GUI:button(100, 100, 80, 50, "end game", function() 
		if love.mouse.isDown(1) then
			print("end gameeeeee")
		end
	end)
end

