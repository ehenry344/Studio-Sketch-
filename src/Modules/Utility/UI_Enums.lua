local StudioTheme = settings().Studio.Theme

local PluginUIEnums = {}

PluginUIEnums.Colors = {
	["Main"] = StudioTheme:GetColor(Enum.StudioStyleGuideColor.MainBackground),
	
	["Button"] = {
		["Main"] = StudioTheme:GetColor(Enum.StudioStyleGuideColor.Button), -- Default Button Color
		["Hover"] = StudioTheme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover),
		["Pressed"] = StudioTheme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Pressed),
	},
	
	["ButtonText"] = {
		["Main"] = StudioTheme:GetColor(Enum.StudioStyleGuideColor.ButtonText),
		["Hover"] = StudioTheme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover),
		["Pressed"] = StudioTheme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Pressed),
		["Selected"] = StudioTheme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Selected),
		["Disabled"] = StudioTheme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Disabled),
	},
	
	["Border"] = {
		["Main"] = StudioTheme:GetColor(Enum.StudioStyleGuideColor.Border),
		["Button"] = StudioTheme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder),
	},
	
	["ScrollFrame"] = {
		["ScrollBar"] = StudioTheme:GetColor(Enum.StudioStyleGuideColor.ScrollBar)
	}, 
}

return PluginUIEnums
