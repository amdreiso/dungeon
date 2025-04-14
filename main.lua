
local Fovy = require "libs.fovy"
local Global = require "global"

local Player = require "obj.player"

Fovy:instanceAdd(Player:new())

function love.load()
end

function love.update(dt)
	for _, obj in ipairs(Global.instances) do
		obj:update(dt)
	end
end

function love.draw()
	for _, obj in ipairs(Global.instances) do
		obj:draw()
	end

	drawDebug()
end


function drawDebug()
	if not Global.debug then return end

	local v = Global.gameInfo.version

	love.graphics.print(Global.gameInfo.name .. " | " .. v[1] .. "." .. v[2] .. " " .. Global.gameInfo.release, 0, 0)
	love.graphics.print("Made by: " .. Global.gameInfo.author, 0, 14)
end


