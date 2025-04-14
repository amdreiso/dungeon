
local Fovy = require "libs.fovy"
local Global = require "global"

local Player = require "obj.player"
local Camera = require "obj.camera"

local player = Player:new()

local camera = Camera:new()
camera:setTarget(player)

Fovy:instanceAdd(player)
Fovy:instanceAdd(camera)


function love.load()
end

function love.update(dt)
	for _, obj in ipairs(Global.instances) do
		obj:update(dt)
	end
end

function love.draw()

	camera:set()

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
end


