local Fovy = require("libs.fovy")
local Global = require("global")

local Player = {
	name = "Player",
  pos = Fovy:vec2(200, 200),
  hsp = 0,
  vsp = 0,
  speed = 2,

	hands = {
		{
			weaponID = 1,
		},

		{
			weaponID = -1,
		}
	},

	handIndex = 1,

  hitbox = Fovy:dim(16, 16),
}

function Player:new(components)
  Player.destroy = function(self)
    self.isDestroyed = true
  end

	for key, val in pairs(components or {}) do
		Player[key] = val
		print(key, val)
	end

  setmetatable(Player, self)
  self.__index = self

	return Player
end

function Player:getWeapon()
	local id = self.hands[self.handIndex].weaponID
	if id == -1 then return nil end
	
	return Global.weaponData[id]
end

function Player:handleWeapon()
	local weapon = self:getWeapon()
	if weapon ~= nil then
	end
end

function Player:movement(dt)
  self.hsp = 0
  self.vsp = 0

  if love.keyboard.isDown("w") then
    self.vsp = self.vsp - self.speed
  end

  if love.keyboard.isDown("s") then
    self.vsp = self.vsp + self.speed
  end

  if love.keyboard.isDown("a") then
    self.hsp = self.hsp - self.speed
  end

  if love.keyboard.isDown("d") then
    self.hsp = self.hsp + self.speed
  end

  if self.hsp ~= 0 and self.vsp ~= 0 then
    self.hsp = self.hsp * 0.7071
    self.vsp = self.vsp * 0.7071
  end

  self.pos.x = self.pos.x + self.hsp
  self.pos.y = self.pos.y + self.vsp
end

function Player:update(dt)
  self:movement(dt)
	self:handleWeapon()
end

function Player:draw()
  love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.hitbox.width, self.hitbox.height)
end

return Player
