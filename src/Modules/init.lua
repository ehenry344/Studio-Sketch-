--[[
gilaga4815

updated : 11 / 5 / 2021

STUDIO SKETCH

Initializer Module that handles prioritized plugin setup 
]]

local PluginUI = script.Parent.Parent.Modules.PluginUI
local Utility = script.Parent.Parent.Modules.Utility

local pluginModules = {} 

-- Load Program 

local function processInit(module) -- Handles The Loading Of the Modules Sequentially 
	local moduleData = require(module) 
	
	if #pluginModules < 1 and not moduleData.IsMain then -- Check To Make Sure the Main Wasn't Already Inserted
		coroutine.yield("initYield")
	end
	
	pluginModules[#pluginModules + 1] = moduleData 
		
	return true 
end

local function startupModules(moduleFolder) -- Initialize the Singletons 
	local coroutineTable = {} 
	
	for _, v in pairs(moduleFolder:GetChildren()) do 		
		local newProcessCoroutine = coroutine.create(processInit) 
		local success, result = coroutine.resume(newProcessCoroutine, v) 
		
		if type(result) == "string" then 
			coroutineTable[#coroutineTable + 1] = newProcessCoroutine 
		end
	end
	
	for _, process in pairs(coroutineTable) do
		coroutine.resume(process)
	end		
end

-- Actually Start the Thing When This is invoked 

return function(mainWidget)  -- Just Create a callable function to be created 
	local ViewSelector = require(script.Parent.Utility.UIClasses.ViewSelector)
	
	startupModules(PluginUI)
		
	local MainFrame = pluginModules[1] 
	MainFrame:SetParent(mainWidget) -- passes in the extra arguments regardless if they are needed or not 
		
	local newSelector = ViewSelector.New(MainFrame.modeMgrFrame)
	
	for i = 2, #pluginModules do
		local element = pluginModules[i]	
		element:SetParent(MainFrame.holderFrame)
		
		newSelector:CreateSelector(element.frameInstance) 
	end
end
