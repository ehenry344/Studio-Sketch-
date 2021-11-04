--[[
gilaga4815

updated : 10 / 27 / 2021

STUDIO SKETCH

ViewSelector class which creates a dynamic view selector system (mainly handles the presentation) of the view system 
]]

local UI_Util = require(script.Parent.Parent.UI_Utility)
local UI_Enums = require(script.Parent.Parent.UI_Enums)

local TextButton = require(script.Parent.TextButton)

local ViewSelector = {}
ViewSelector.__index = ViewSelector

function ViewSelector.New(selectorFrame)
	assert(selectorFrame, "ERR : Argument 1 (missing or nil)") 
	
	local self = {
		vsFrame = selectorFrame, 
		
		viewFrames = {}, 
		buttons = {}, 
		
		currentlySel = nil, 
	}
	
	return setmetatable(self, ViewSelector)
end

function ViewSelector:CreateSelector(viewFrame)
	assert(viewFrame, "ERR : Argument 1 (missing or nil)")
	
	table.insert(self.viewFrames, viewFrame)
	
	local newButton = TextButton.New(viewFrame.Name, Vector2.new(80, 21), self.vsFrame)
	
	newButton:UpdatePosition(UDim2.new(0, (#self.vsFrame:GetChildren() - 1) * newButton.buttonInstance.AbsoluteSize.X, 0, 0))
	newButton:SetupMouseEnterLeave()
	
	newButton:SetupSwitching(function(isToggled)
		if not isToggled then return end 
		
		-- Remove the Padding Instance From the Button That is Currently In Use 
		
		local paddingInstance = self.currentlySel and self.currentlySel.buttonInstance and self.currentlySel.buttonInstance:FindFirstChild("UIPadding")
		
		if paddingInstance and self.currentlySel ~= newButton then
			paddingInstance:Destroy()
			
			self.currentlySel.buttonInstance.BackgroundColor3 = UI_Enums.Colors.Button.Main
			self.currentlySel.buttonInstance.TextColor3 = UI_Enums.Colors.ButtonText.Main
		end		
		
		for _, v in pairs(self.viewFrames) do
			v.Visible = v == viewFrame 
		end
		
		self.currentlySel = newButton 
	end)
	
	table.insert(self.buttons, newButton)
end

return ViewSelector
