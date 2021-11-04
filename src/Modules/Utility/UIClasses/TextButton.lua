--[[
gilaga4815

updated : 10 / 13 / 2021

STUDIO SKETCH

TextButton class that mimics the appearance of the Roblox Studio Textbutton
]]

local UI_Enums = require(script.Parent.Parent.UI_Enums)

local TextButton = {}
TextButton.__index = TextButton

function TextButton.New(name, sizeData, parent)
	assert(name, "ERR : Argument 1 (missing or nil)")
	assert(type(name) == "string", "ERR : Argument 1 (Invalid Type, string expected got " .. type(name) .. ")")
	assert(sizeData, "ERR : Argument 2 (missing or nil)") 
	assert(typeof(sizeData) == "Vector2", "ERR : Argument 2 (Invalid Type, Vector2 expected got " .. typeof(sizeData) .. ")")

	local self = {
		buttonInstance = Instance.new("TextButton"),
		connections = {}, 
	}
	
	self.buttonInstance.Name = name
	self.buttonInstance.Text = name
	
	self.buttonInstance.Font = Enum.Font.Arial
	
	self.buttonInstance.AutoButtonColor = false -- prevent overwritten enter and leave colors
	
	self.buttonInstance.BackgroundColor3 = UI_Enums.Colors.Button.Main
	self.buttonInstance.BorderColor3 = UI_Enums.Colors.Border.Main
	self.buttonInstance.TextColor3 = UI_Enums.Colors.ButtonText.Main
	
	self.buttonInstance.BorderSizePixel = 1 
	self.buttonInstance.BorderMode = Enum.BorderMode.Inset 
	
	self.buttonInstance.TextSize = 11.5 
	self.buttonInstance.Size = UDim2.new(0, sizeData.X, sizeData.Y == 0 and 1, sizeData.Y) 
	
	if parent then
		self.buttonInstance.Parent = parent 
	end
	
	return setmetatable(self, TextButton)
end

function TextButton:SetupSwitching(callback) -- This will allow for the button to become a switchable button 
	assert(callback, "ERR : Argument 1 (MISSING OR NIL)") 
	assert(type(callback) == "function", "ERR : Argument 1 (INVALID TYPE)")

	self.connections[#self.connections + 1] = self.buttonInstance.MouseButton1Down:Connect(function()
		local switchStatus = self.buttonInstance.BackgroundColor3 ~= UI_Enums.Colors.Button.Pressed

		if switchStatus then
			local newPadding = Instance.new("UIPadding")

			newPadding.Parent = self.buttonInstance
			newPadding.PaddingBottom = UDim.new(0, -3.5) 

			self.buttonInstance.BackgroundColor3 = UI_Enums.Colors.Button.Pressed
			self.buttonInstance.TextColor3 = UI_Enums.Colors.ButtonText.Selected 
		end

		callback(switchStatus)
	end)
end

function TextButton:SetupMouseEnterLeave()
	local originalColor = self.buttonInstance.BackgroundColor3 -- Holds The Original Color Of The Button To Be Replaced 
	
	self.connections[#self.connections + 1] = self.buttonInstance.MouseEnter:Connect(function()
		if self.buttonInstance.BackgroundColor3 ~= UI_Enums.Colors.Button.Pressed then -- Prevents A Pressed Button From Being Overriden
			self.buttonInstance.BackgroundColor3 = UI_Enums.Colors.Button.Hover
		end
	end)
	
	self.connections[#self.connections + 1] = self.buttonInstance.MouseLeave:Connect(function()
		if self.buttonInstance.BackgroundColor3 == UI_Enums.Colors.Button.Hover then
			self.buttonInstance.BackgroundColor3 = originalColor 
		end
	end)
end

function TextButton:Disconnect()
	for i = 1, #self.connections do 
		if typeof(self.connections[i]) == "RBXScriptConnection" then
			self.connections[i]:Disconnect() 
		end 
	end
end

function TextButton:UpdatePosition(position)
	assert(position, "ERR : Argument 1 (MISSING OR NIL)") 
	assert(typeof(position) == "UDim2", "ERR : Argument 1 (INVALID TYPE)")
	
	self.buttonInstance.Position = position 
end



return TextButton
