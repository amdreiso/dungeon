
local Object = {}

function Object:new(name)
	local object = {}
	object.name = name or "unnamed object";
	object.destroy = function(self)
		print("Object destroyed")
		self.isDestroyed = true
	end

	setmetatable(object, self)
	self.__index = self
	return object
end

function Object:extend()
	local object = self:new()
	setmetatable(object, self)
	self.__index = self
	return object
end

function Object:implement(...)
	for _, object in ipairs{...} do
		for k, v in pairs(object) do
			if self[k] == nil then
				self[k] = v
			end
		end
	end
end

function Object:is(Object)
	local mt = getmetatable(self)
	while mt do
		if mt == Object then
			return true
		end
		mt = getmetatable(mt)
	end
	return false
end

return Object


