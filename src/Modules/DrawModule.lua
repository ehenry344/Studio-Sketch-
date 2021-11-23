--[[
gilaga4815

updated : 11 / 22 / 2021

STUDIO SKETCH

Drawing System Module : 

Utility for the drawing system that allows for independent rendering of ui elements without being proprietary to the drawing implements
]] 

-- defined for efficiency 
local atan = math.atan
local pi = math.pi


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
	
	-- Line Math
	
	local positionDiff = pos1 - pos2
	local thetaRot = math.atan(positionDiff.Y / positionDiff.X) * (180 / math.pi)
	
	newLine.AnchorPoint = Vector2.new(0.5, 0.5)
	newLine.Size = UDim2.new(0, positionDiff.Magnitude, 0, 5) -- Magnitude is the hypotenuse 
	newLine.Position = UDim2.new(0, pos1.X - positionDiff.X / 2, 0, pos1.Y - positionDiff.Y / 2)
	newLine.Rotation = thetaRot 
	
	return newLine 
end

return DrawModule
