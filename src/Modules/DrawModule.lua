--[[
gilaga4815

updated : 11 / 5 / 2021

STUDIO SKETCH

Drawing System Module : 

Utility for the drawing system that allows for independent rendering of ui elements without being proprietary to the drawing implements
]] 

local DrawModule = {}

function DrawModule.RenderPoint() 
	local newPoint = Instance.new("Frame")
	
	newPoint.BorderSizePixel = 0 
	newPoint.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	newPoint.Size = UDim2.fromOffset(5, 5)
	newPoint.ZIndex = 2 
	
	return newPoint
end

function DrawModule.RenderLine(pos1, pos2)
	local newLine = Instance.new("Frame")
	
	newLine.BorderSizePixel = 0
	newLine.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	newLine.ZIndex = 2 
	
	-- Math to handle the line generation between the two points as well as the rotation :) 
	
	local bLength = (pos2.Y - pos1.Y) -- Didn't declare a since b is the only one used twice :) 
	local hypLength = math.sqrt((pos2.X - pos1.X)^2 + (bLength)^2) -- gets length of the hypotenuse between the two points 
	
	local rotationValue = math.deg(math.asin(bLength / hypLength)) 
	
	-- Math is handled and now we do the sizing 
	
	newLine.Size = UDim2.fromOffset(hypLength, 5) 
	newLine.Rotation = rotationValue 
	
	return newLine 
end

return DrawModule
