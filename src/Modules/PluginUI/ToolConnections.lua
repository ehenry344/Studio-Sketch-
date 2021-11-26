--[[
gilaga4815

updated : 11 / 22 / 2021

STUDIO SKETCH

Tool Connections Module 

This module holds all of the connection data for the tools that are used within the studio sketch library 
]]

local DrawModule = require(script.Parent.Parent.Parent.DrawModule)

local ToolConns = {
	["Pencil"] = function(frame)
		local connections = {} 
		
		local frameOffset = frame.AbsolutePosition.X 				
		local lastFramePosition = nil -- holds the position of the last frame used 
		
		local recentlyAdded = {} -- holds the instances to check for overlapping lines 
		
		connections[#connections + 1] = frame.InputChanged:Connect(function(inputData)
			if inputData.UserInputType == Enum.UserInputType.MouseMovement then
				local newPos = Vector2.new(inputData.Position.X - frameOffset, inputData.Position.Y) 
				
				if lastFramePosition then
					local newLine = DrawModule.RenderLine(lastFramePosition, newPos)
					newLine.Parent = frame 
					
					recentlyAdded[#recentlyAdded + 1] = newLine 
				end
				
				lastFramePosition = newPos 
			end
		end)
		
		return connections, recentlyAdded 
	end,
	["Eraser"] = function(frame)
		local connections = {} 
		
		local frameOffset = frame.AbsolutePosition.X
		
		--[[ MORE STUFF FOR VISUALIZATION 
		local neighborFrames = {} 
		
		spawn(function()
			while wait(10) do
				for _,v in pairs(neighborFrames) do
					v:Destroy()
				end
			end
		end)
		
		local newFolder = frame:FindFirstChild("Folder") or Instance.new("Folder", frame.Parent)
		]] 
	
		connections[#connections + 1] = frame.InputChanged:Connect(function(inputData)
			if inputData.UserInputType == Enum.UserInputType.MouseMovement then
				local cPos = Vector2.new(inputData.Position.X - frameOffset, inputData.Position.Y) 
				
				for _,v in pairs(frame:GetChildren()) do
					local framePos = Vector2.new(v.AbsolutePosition.X, v.AbsolutePosition.Y)
					local diffPos = framePos - cPos 
					
					if math.abs(diffPos.Magnitude) < 20 then
						v:Destroy() -- Eraser system :) 
					end
				end
				
				--[[ UGLY LINE VISUALIZATION BUT ITS COOL 
				for _, v in pairs(frame:GetChildren()) do					
					if v.Name ~= "Line" then
						local fPos = Vector2.new(v.AbsolutePosition.X, v.AbsolutePosition.Y)
						local diffPos = fPos - cPos 
						
						if math.abs(diffPos.Magnitude) < 300 then 
							if not neighborFrames[v] then
								local newLine = DrawModule.RenderLine(cPos, fPos)
								newLine.Name = "Line"
								newLine.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
								newLine.Parent = frame
								newLine.Size = UDim2.fromOffset(newLine.Size.X.Offset, 2)
								
								neighborFrames[v] = newLine 
							else
								neighborFrames[v]:Destroy()
								neighborFrames[v] = nil 
							end
						elseif neighborFrames[v] then
							neighborFrames[v]:Destroy() 
							neighborFrames[v] = nil 
						end
					end		
				end			
				]] 
			end
		end)
		
		return connections 
	end,
	["Line"] = function(frame) 
		local connections = {} 
		
		local frameOffset = frame.AbsolutePosition.X 
		
		local lStart = nil 
		local currentLine = nil 
		
		connections[#connections + 1] = frame.InputChanged:Connect(function(inputData)			
			if not lStart then 
				lStart = Vector2.new(inputData.Position.X - frameOffset, inputData.Position.Y)
			end			
			
			if inputData.UserInputType == Enum.UserInputType.MouseMovement then
				if currentLine then 
					currentLine:Destroy() 
				end
				currentLine = DrawModule.RenderLine(lStart, Vector2.new(inputData.Position.X - frameOffset, inputData.Position.Y))  
				currentLine.Parent = frame 
			end
		end)
		
		return connections 
	end,
}

return ToolConns 
