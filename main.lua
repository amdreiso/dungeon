
local Fovy = require("libs.fovy")

local Global = require("global")
local Level = require("level")

local Player = require("obj.player")
local Camera = require("obj.camera")


local player = Player:new()
local camera = Camera:new()
camera:setTarget(player)

Fovy:instanceAdd(player, {
	pos = Fovy:vec2(0, 0)
})
Fovy:instanceAdd(camera)


-- Levels
Level:new(
	"entrance",
	"entrance",
	Level:layout(Fovy:dim(20, 20))
)


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

		if Global.debug then
			local level = Global.levels["entrance"]
			for i=1, #level.layout do
				for j=1, #level.layout[i] do
					love.graphics.print(
						level.layout[i][j].id,
						j * Global.cellSize,
						i * Global.cellSize
					)
				end
			end

			love.graphics.setColor(255, 0, 0)

			love.graphics.rectangle("line", obj.pos.x, obj.pos.y, obj.hitbox.width, obj.hitbox.height)

			love.graphics.setColor(255, 255, 255)
		end
	end

	camera:unset()

	drawDebug()
end

function drawDebug()
	if not Global.debug then
		return
	end

	local v = Global.gameInfo.version

	love.graphics.print(Global.gameInfo.name .. " | " .. v[1] .. "." .. v[2] .. " " .. Global.gameInfo.release, 0, 0)
	love.graphics.print("Made by: " .. Global.gameInfo.author, 0, 14)
	love.graphics.print("x: " .. player.pos.x .. " y: " .. player.pos.y, 0, 28)
end
