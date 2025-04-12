
local Fovy = require "libs.fovy"
local Global = require "global"


function love.load()
end

function love.update(dt)
end

function love.draw()
	drawDebug()
end


function drawDebug()
	if not Global.debug then return end

	love.graphics.print(Global.gameInfo.name, 0, 0)
	love.graphics.print("Made by: " .. Global.gameInfo.author, 0, 14)
end


