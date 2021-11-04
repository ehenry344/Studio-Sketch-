--[[
gilaga4815

updated : 11 / 3 / 2021

STUDIO SKETCH

UI Utility Module : Houses Different Methods For Use Across The Plugin For User Interface 
]]

local UIEnums = require(script.Parent.UI_Enums)

local PluginUIUtil = {}

function PluginUIUtil.GetPropScale(offsetHeight, decimalPVal)
	decimalPVal = 10^decimalPVal	
	
	local returnDecimal = 1 - (1 / offsetHeight)	
	
	return (math.floor((returnDecimal * decimalPVal) + 0.5)) / decimalPVal
end


return PluginUIUtil
