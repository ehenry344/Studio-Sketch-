--[[
gilaga4815

updated : 11 / 3 / 2021

STUDIO SKETCH

Canvas Frame Singleton Module : 

This module handles creation of the canvas frame, which is what the center of the plugin pretty much is
]]


local UIEnums = require(script.Parent.Parent.Utility.UI_Enums)
local Toolbar = require(script.Toolbar)

local DrawModule = require(script.Parent.Parent.DrawModule)

local Canvas = {} 

local function renderFrame() -- Created Function For the Sake Of Cleanliness 
	Canvas.frameInstance = Instance.new("Frame")
	Canvas.sideFrame = Instance.new("Frame")
	Canvas.canvasFrame = Instance.new("Frame")
	
	-- Create Holder Frame  
	
	Canvas.frameInstance.Size = UDim2.fromScale(1, 1)
	Canvas.frameInstance.BackgroundTransparency = 1 
	Canvas.frameInstance.Name = "Canvas"
	
	-- Create Sidebar
	
	Canvas.sideFrame.Parent = Canvas.frameInstance
	
	Canvas.sideFrame.Size = UDim2.new(0, 23, 1)
	Canvas.sideFrame.BackgroundColor3 = UIEnums.Colors.Main
	Canvas.sideFrame.BorderSizePixel = 1 
	Canvas.sideFrame.BorderColor3 = UIEnums.Colors.Border.Main
	Canvas.sideFrame.BorderMode = Enum.BorderMode.Inset
	
	-- Create Canvas 
	
	Canvas.canvasFrame.Parent = Canvas.frameInstance
	
	Canvas.canvasFrame.Size = UDim2.new(0, Canvas.frameInstance.AbsoluteSize.X - Canvas.sideFrame.AbsoluteSize.X, 1) 
	Canvas.canvasFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Canvas.canvasFrame.BorderMode = Enum.BorderMode.Inset
	Canvas.canvasFrame.BorderColor3 = UIEnums.Colors.Border.Main
	Canvas.canvasFrame.BorderSizePixel = 1 
	Canvas.canvasFrame.ZIndex = 2 
	Canvas.canvasFrame.Position = UDim2.fromOffset(23, 0)
	
	Canvas.frameInstance:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Allows for dynamic size update :) 
		Canvas.canvasFrame.Size = UDim2.new(0, Canvas.frameInstance.AbsoluteSize.X - Canvas.sideFrame.AbsoluteSize.X, 1)
	end)
end

renderFrame() 

-- Now Render The Toolbar 

local barUpdate = Toolbar.init(Canvas.sideFrame)

-- Setup the connections to draw on the canvas and such

local function connectCanvas()
	local moveConnection = nil 
	
	Canvas.canvasFrame.InputBegan:Connect(function(inputData, processed) -- This will allow for the mouse change thing 
		if processed then return end
		
		-- this is where the accessing of the draw callback will occur 
		
		if inputData.UserInputType == Enum.UserInputType.MouseButton1 then
			print("Working")
			
			moveConnection  = Canvas.canvasFrame.MouseMoved:Connect(function(posX, posY) 
				print("This is updating")
				-- The code here is just driver code that will be replaced later 
				
				local cPoint = DrawModule.RenderPoint() 
				
				cPoint.Parent = Canvas.canvasFrame
			
				cPoint.Position = UDim2.fromOffset(posX - Canvas.canvasFrame.AbsolutePosition.X, posY) 
				
				cPoint.ZIndex = 2 
				
				print(cPoint.Position)
			end)
		end
	end)
	
	Canvas.canvasFrame.InputEnded:Connect(function(inputData, processed)
		if processed then return end
		
		if inputData.UserInputType == Enum.UserInputType.MouseButton1 and moveConnection then
			moveConnection:Disconnect() 
		end
	end)
end

connectCanvas() 

-- Canvas Functions 

function Canvas:SetParent(parent)
	self.frameInstance.Parent = parent
end

-- Handle Rest Of the Initialization Process For the Frame 


return Canvas
