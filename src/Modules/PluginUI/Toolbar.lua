--[[
gilaga4815

updated : 11 / 3 / 2021

STUDIO SKETCH

Toolbar Singleton Module : 

This module handles the UI aspect of the toolbar as well as the logic and toolbar state 
]]

local UIEnums = require(script.Parent.Parent.Parent.Utility.UI_Enums)
local DrawModule = require(script.Parent.Parent.Parent.DrawModule)

local CanvasItems = {
	["Pencil"] = {"rbxassetid://7889836519"}, 
	["Eraser"] = {"rbxassetid://7889861543"},
}

local Toolbar = {}

Toolbar.buttons = {} 
Toolbar.activeTool = nil

local function connectButton(button)
	if not button then return end
	
	button.MouseEnter:Connect(function()
		if button.ImageColor3 == UIEnums.Colors.ButtonText.Disabled then
			button.ImageColor3 = UIEnums.Colors.ButtonText.Hover
		end
	end)
	
	button.MouseLeave:Connect(function()
		if button.ImageColor3 == UIEnums.Colors.ButtonText.Hover then
			button.ImageColor3 = UIEnums.Colors.ButtonText.Disabled
		end
	end)
	
	button.MouseButton1Down:Connect(function()
		if button.ImageColor3 == UIEnums.Colors.ButtonText.Selected then return end -- If it's not already the the current button
		
		if Toolbar.activeTool then
			Toolbar.activeTool.ImageColor3 = UIEnums.Colors.ButtonText.Disabled 
		end
		
		Toolbar.activeTool = button
		button.ImageColor3 = UIEnums.Colors.ButtonText.Selected
	end)
end

function Toolbar.init(toolbarFrame) -- Handles UI Rendering 
	local baseButton = Instance.new("ImageButton")
	
	baseButton.Size = UDim2.new(1, 0, 0, 23)
	baseButton.AutoButtonColor = false
	baseButton.BackgroundTransparency = 1 
	baseButton.ImageColor3 = UIEnums.Colors.ButtonText.Disabled -- Using Button Text Colors to make it easier
	
	for iName, iData in pairs(CanvasItems) do
		local itemButton = baseButton:Clone()
		
		itemButton.Image = iData[1]
		itemButton.Position = UDim2.fromOffset(0, #toolbarFrame:GetChildren() * baseButton.AbsoluteSize.Y) 
		itemButton.Name = iName
		
		table.insert(Toolbar.buttons, itemButton)	
		itemButton.Parent = toolbarFrame
		
		connectButton(itemButton)
	end
end

return Toolbar 
