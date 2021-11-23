--[[
gilaga4815

updated : 11 / 22 / 2021

STUDIO SKETCH

Canvas Frame Singleton Module : 

This module handles creation of the canvas frame, which is what the center of the plugin pretty much is
]]

local UIEnums = require(script.Parent.Parent.Utility.UI_Enums)
local UIUtil = require(script.Parent.Parent.Utility.UI_Utility)

local Toolbar = require(script.Toolbar)
local ToolConnections = require(script.ToolConnections)

local Canvas = {} 

local function packTable(t1, t2) -- ByReference Table Packing 
	for i = 1, #t2 do 
		t1[#t1 + 1] = t2[i] 
	end
end

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
	local useConnections = {} -- this will hold the connections that are currently in use for the canvas 
	
	Canvas.canvasFrame.InputBegan:Connect(function(inputData, processed) -- This will allow for the mouse change thing 
		if processed then return end
		
		local newUpdater = ToolConnections[Toolbar.GetActiveTool()] 
		
		if newUpdater and inputData.UserInputType == Enum.UserInputType.MouseButton1 then			
			 packTable(useConnections, newUpdater(Canvas.canvasFrame))
		end	
	end)
		
	Canvas.canvasFrame.InputEnded:Connect(function(inputData, processed)
		if processed then return end		
		
		if inputData.UserInputType == Enum.UserInputType.MouseButton1 and useConnections then			
			for i = 1, #useConnections do 	
				useConnections[i]:Disconnect()
				useConnections[i] = nil 
			end
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
