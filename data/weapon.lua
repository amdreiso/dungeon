
local Global = require "global"
local Fovy = require "libs.fovy"

Global.weaponData = {}
local Weapon = {}

function Weapon:getDefaultComponents()
	return {
		precision = 0,
		recoil = 0,
		cadency = 0,
	}
end

function Weapon:create(id, name, components)
	local weapon = {}
	weapon.name = name
	weapon.components = Weapon:getDefaultComponents()

	Fovy:merge(weapon.components, components or {})

	Global.weaponData[id] = weapon
end

return Weapon

