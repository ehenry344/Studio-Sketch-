--[[
gilaga4815

updated : 11 / 3 / 2021

STUDIO SKETCH

Drawing System Module : 

Utility for the drawing system that allows for independent rendering of ui elements without being proprietary to the drawing implements
]] 

local DrawModule = {}

function DrawModule.RenderPoint() 
	local newPoint = Instance.new("Frame")
	
	newPoint.BorderSizePixel = 0 
	newPoint.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	newPoint.Size = UDim2.fromOffset(3, 3)
	
	return newPoint
end

return DrawModule
