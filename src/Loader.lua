--[[
gilaga4815

written : 9 / 25 / 2021
updated : 11 / 5 / 2021 

Studio Sketch Loader / Main Script That Manages all of the important stuff to make it a plugin
]]

-- Modules

local initializer = require(script.Parent.Modules.init)

-- Other Plugin Stuff

local pluginToolbar = plugin:CreateToolbar("Sketch Toolbar")
local sketchToggle = pluginToolbar:CreateButton("Toggle Canvas", "Toggle Canvas Visibility", "rbxassetid://7565683506")

local canvasWidgetData = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 200, 200)
local sketchWidget = plugin:CreateDockWidgetPluginGui("StudSketch_Canvas", canvasWidgetData) 

-- Plugin Code Here 

initializer(sketchWidget) 
-- Widget Stuff Below 

sketchWidget.Title = "Studio Sketch Canvas"

sketchToggle.Click:Connect(function()
	sketchWidget.Enabled = not sketchWidget.Enabled
end)



