--[[
gilaga4815

updated : 10 / 27 / 2021

STUDIO SKETCH

Main Frame Singleton Module : 

This module handles creation of the MainFrame singleton which holds all ui elements for the plugin
]]

local UIEnums = require(script.Parent.Parent.Utility.UI_Enums)
local PluginUIUtil = require(script.Parent.Parent.Utility.UI_Utility)

local MainFrame = {
	primaryFrame = Instance.new("Frame"),
	modeMgrFrame = Instance.new("Frame"),
	holderFrame = Instance.new("Frame"),
} 

MainFrame.IsMain = true 

-- MainFrame Characteristics 

MainFrame.primaryFrame.Name = "PluginMainFrame"
MainFrame.primaryFrame.Size = UDim2.fromScale(1, 1)
MainFrame.primaryFrame.BorderSizePixel = 1

-- Mode Manager Frame Characteristics 

MainFrame.modeMgrFrame.Parent = MainFrame.primaryFrame

MainFrame.modeMgrFrame.Size = UDim2.new(1, 0, 0, 23)
MainFrame.modeMgrFrame.Position = UDim2.fromScale(0, 1)
MainFrame.modeMgrFrame.AnchorPoint = Vector2.new(0, 1)
MainFrame.modeMgrFrame.BorderSizePixel = 1 
MainFrame.modeMgrFrame.BorderColor3 = UIEnums.Colors.Border.Main
MainFrame.modeMgrFrame.BorderMode = Enum.BorderMode.Inset
MainFrame.modeMgrFrame.BackgroundColor3 = UIEnums.Colors.Main

-- Holder Frame Characteristics 

MainFrame.holderFrame.Parent = MainFrame.primaryFrame
MainFrame.holderFrame.Size = UDim2.fromScale(1, PluginUIUtil.GetPropScale(MainFrame.modeMgrFrame.Size.Y.Offset, 2) + 0.01)
MainFrame.holderFrame.BackgroundTransparency = 1 
MainFrame.holderFrame.Name = "Holder"
MainFrame.holderFrame.BorderSizePixel = 0

-- Update Handling 

MainFrame.primaryFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	MainFrame.holderFrame.Size = UDim2.new(1, 0, 0, MainFrame.primaryFrame.AbsoluteSize.Y - MainFrame.modeMgrFrame.Size.Y.Offset)
end)

function MainFrame:SetParent(parent)
	self.primaryFrame.Parent = parent 
end



return MainFrame
