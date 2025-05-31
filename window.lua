
local Fovy = require "fovy"
local Global = require "global"

local Window = {
	size = Fovy:dim(1280, 720),
	title = "gamble game"
}

function Window:setup()
	love.window.setMode(self.size.width, self.size.height)

	love.graphics.setDefaultFilter("nearest", "nearest")
end

return Window

