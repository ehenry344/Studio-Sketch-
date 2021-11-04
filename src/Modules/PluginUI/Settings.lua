--[[
gilaga4815

updated : 10 / 27 / 2021

STUDIO SKETCH

Settings Frame Singleton Module : 

This module handles creation of the settings frame, which handles configuration of the different settings contained within the plugin
]]

local UIEnums = require(script.Parent.Parent.Utility.UI_Enums)

local Settings = {
	frameInstance = Instance.new("Frame"),
}

Settings.frameInstance.Size = UDim2.fromScale(1, 1)
Settings.frameInstance.Name = "Settings"
Settings.frameInstance.BorderSizePixel = 1
Settings.frameInstance.BorderColor3 = UIEnums.Colors.Border.Main
Settings.frameInstance.BorderMode = Enum.BorderMode.Inset
Settings.frameInstance.BackgroundColor3 = UIEnums.Colors.Main

function Settings:SetParent(parent)
	self.frameInstance.Parent = parent
end





return Settings
