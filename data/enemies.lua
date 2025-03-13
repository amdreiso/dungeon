
local Fovy = require "fovy"
local Global = require "global"

function CreateEnemy(id, ...)
	Global.EnemyList[id] = {}
	
	for key, value in ipairs({...}) do
		-- set attributes
		Global.EnemyList[id] = value
	end
end

-- Thief
local eThief = {
	hitbox = Fovy:dim(19, 11),
}

function eThief:load(obj)
	for key, value in ipairs(eThief) do
		obj[key] = value
	end
end

function eThief:update(obj, dt)
end

CreateEnemy(0, eThief)

return EnemyList

