
local Fovy = require "fovy"
local Global = require "global"

local Level = {
	size = Fovy:dim(500, 500),
	map = {},
	tileSize = 16,
	instances = {},
}

function Level:create() 
	local player = Global.Instances["player"]:new({
		pos = Fovy:vec2(10, 0)
	})

	local camera = Global.Instances["camera"]:new()
	camera:setPosition(0, 0)
	camera:setTarget(player)

	local enemy = Global.Instances["enemy"]:new()
	enemy.pos = Fovy:vec2(100, 100)

	local enclosure = Global.Instances["enclosure"]:new({
		pos = Fovy:vec2(64, 64)
	})

	Level:instanceAdd(player)
	Level:instanceAdd(camera)
	Level:instanceAdd(enemy)
	Level:instanceAdd(enclosure)
	Level:instanceAdd(Global.Instances["enclosure"]:new({
		pos = Fovy:vec2(256, 64),
		dim = Fovy:dim(128, 128),
	}))

	Level:loadMap()
end

function Level:tile(tileID)
	local tile = {}
	tile.id = tileID
	return tile
end

function Level:loadMap()
	for i=0, self.size.width / self.tileSize do
		self.map[i] = {}
		for j=0, self.size.height / self.tileSize do
			self.map[i][j] = Level:tile(0)
		end
	end
end

function Level:drawMap()
	for i=0, self.size.width / self.tileSize do
		for j=0, self.size.height / self.tileSize do
			local tile = self.map[i][j]
			local size = self.tileSize

			if tile.id ~= 0 then
				local spr = Global.TileList[tile.id].sprite
				love.graphics.draw(spr, i * size, j * size)
			end

			love.graphics.setColor(1,1,1)
		end
	end
end

function Level:instanceAdd(obj, ...)
	local o = obj
	table.insert(self.instances, o)
end

function Level:instanceFind(index)
	for _, instance in ipairs(self.instances) do
		print(instance.id)
		if instance.id == index then
			return instance
		end
	end
end

function Level:getMouseTile()
	local x = math.floor(Global.MousePos.x / self.tileSize) * self.tileSize 
	local y = math.floor(Global.MousePos.y / self.tileSize) * self.tileSize 

	return x, y
end

function Level:update(dt)
end

function Level:draw()
	local mx, my = self:getMouseTile()

	self:drawMap()

	if love.mouse.isDown(1) then
		local x = math.floor(mx / self.tileSize)
		local y = math.floor(my / self.tileSize)

		if x < 0 or y < 0 then
			return false
		end

		self.map[x][y].id = 1
	else
		love.graphics.rectangle("line", mx, my, self.tileSize, self.tileSize)
	end
end

return Level

