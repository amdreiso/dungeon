
local Fovy = require "libs.fovy"
local GUI = {}

function GUI:drawRect(style, x, y, width, height, color)
	local c = color or Fovy:rgba(1, 1, 1, 1)
	love.graphics.setColor(c.r, c.g, c.b, c.a)
	love.graphics.rectangle(style, x - width / 2, y - height / 2, width, height)
end

function GUI:button(x, y, width, height, label, hoverFunction)
	local mx, my = love.mouse.getPosition()
	local hover = (mx > x - width / 2 and mx < x + width / 2 and my < y + height / 2 and my > y - height / 2)

	GUI:drawRect("line", x, y, width, height)

	love.graphics.print(label, x, y)

	if hover then
		GUI:drawRect("fill", x, y, width, height, Fovy:rgba(1, 1, 1, 0.25))
		hoverFunction()
	end
end

return GUI

