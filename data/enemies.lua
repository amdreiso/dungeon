
local Fovy = require "fovy"
local Global = require "global"

function CreateEnemy(id, ...)
	Global.EnemyList[id] = {}
	
	for key, value in ipairs({...}) do
		-- set attributes
		Global.EnemyList[id][key] = value
	end
end

-- Thief
CreateEnemy(0, {
	hitbox = Fovy:dim(11, 11),

	update = function()
		self.pos.x = self.pos.x + 2
		self.pos.y = self.pos.y + 2
	end
})

return EnemyList

