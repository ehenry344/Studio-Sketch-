--[[
gilaga4815

updated : 11 / 26 / 2021

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

function PluginUIUtil.PropertyPrint(instance, properties)
	if type(properties) ~= "table" then return end
	
	local returnString = ""	
	
	for _,v in pairs(properties) do		
		returnString = returnString .. v .. " : " .. tostring(instance[v]) .. "\n"
	end
	
	return returnString 
end

function PluginUIUtil.CreatePropLabel(text)
	local newLabel = Instance.new("TextLabel")
	
	newLabel.AutomaticSize = Enum.AutomaticSize.XY
	
	newLabel.TextWrapped = true 
	newLabel.Text = text 
	newLabel.TextSize = 11 
	newLabel.TextColor3 = UIEnums.Colors.ButtonText.Main
	newLabel.Font = Enum.Font.Arial
	
	newLabel.BorderSizePixel = 1
	newLabel.BorderMode = Enum.BorderMode.Inset
	
	newLabel.BackgroundColor3 = UIEnums.Colors.Button.Main
	
	return newLabel 
end

return PluginUIUtil
