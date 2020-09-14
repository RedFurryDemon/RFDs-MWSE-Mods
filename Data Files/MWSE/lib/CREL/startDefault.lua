local this = {}
local common = require("CREL.common")
local menus = require("CREL.menus")

local trapdoorTimer

--joke's on you: this chain of functions doesn't override any vanilla script; instead, it recreates interactions in lua... because reasons, I suppose

local function overrideScriptWalkGuard06()
	tes3.say{reference = "chargen boat guard 2", soundPath = "vo\\Misc\\CharGenWalk3.wav", subtitle = "On deck now, prisoner."}
	--timer.start{ duration = 6, type = timer.simulate, callback = overrideUsefulScripts02 }
end

local function overrideScriptWalkGuard05()
	if (mwscript.getDistance({ reference = "chargen name", target = tes3.mobilePlayer }) <= 130 ) then
		trapdoorTimer:cancel()
		tes3.setAITravel{ reference = "chargen boat guard 2", destination = {185, 174, 170}}
		tes3.say{reference = "chargen boat guard 2", soundPath = "Vo\\Misc\\CharGenWalk2.wav", subtitle = "Get yourself up on deck, and let's keep this as civil as possible."}
		timer.start{ duration = 6, type = timer.simulate, callback = overrideScriptWalkGuard06 }
	end
end

local function overrideScriptWalkGuard04()
	trapdoorTimer = timer.start{ duration = 0.5, type = timer.simulate, callback = overrideScriptWalkGuard05, iterations = -1 }
end

local function overrideScriptWalkGuard03()
	tes3.runLegacyScript{command = '"chargen boat guard 2"->AIEscort Player, 12, 195, 100, 170'}
	timer.start{ duration = 8, type = timer.simulate, callback = overrideScriptWalkGuard04 }
end

local function overrideScriptWalkGuard02()
	tes3.say{reference = "chargen boat guard 2", soundPath = "Vo\\Misc\\CharGenWalk1.wav", subtitle = "This is where you get off, come with me."}
	common.enableControls()
	timer.start{ duration = 2.5, type = timer.simulate, callback = overrideScriptWalkGuard03 }
end

local function overrideScriptWalkGuard01()
	tes3.setAITravel{ reference = "chargen boat guard 2", destination = {90, -90, -88}}
	timer.start{ duration = 16, type = timer.simulate, callback = overrideScriptWalkGuard02 }
end

local function overrideScriptJiub05()
	if (mwscript.getDistance({ reference = "chargen name", target = tes3.mobilePlayer }) <= 150 ) then
		tes3.say{reference = "chargen name", soundPath = "vo\\Misc\\CharGenName4.wav", subtitle = "You better do what they say."}
	end
	--timer.start{ duration = 6, type = timer.simulate, callback = overrideUsefulScripts02 }
end

local function overrideScriptJiub04()
	tes3.playAnimation{reference = "chargen name", group = "idle3"}
	tes3.say{reference = "chargen name", soundPath = "vo\\Misc\\CharGenName3.wav", subtitle = "Quiet, here comes the guard."}
	timer.start{ duration = 16, type = timer.simulate, callback = overrideScriptJiub05 }
end

--[[local function overrideScriptJiub04()
	tes3.say{reference = "chargen name", soundPath = "Vo\\Misc\\CharGenName1.wav", subtitle = "Stand up, there you go. You were dreaming. What's your name?"}
	timer.start{ duration = 6, type = timer.simulate, callback = overrideScriptJiub05 }
end]]

local function overrideScriptJiub03()
	tes3.say{reference = "chargen name", soundPath = "vo\\Misc\\CharGenName2.wav", subtitle = "Well, not even last night's storm could wake you. I heard them say we've reached Morrowind. I'm sure they'll let us go."}
	timer.start{ duration = 14, type = timer.simulate, callback = overrideScriptJiub04 }
end

local function overrideScriptJiub02()
	menus.createMenuName(0.2, overrideScriptJiub03)
end

local function overrideScriptJiub01()
	tes3.say{reference = "chargen name", soundPath = "Vo\\Misc\\CharGenName1.wav", subtitle = "Stand up, there you go. You were dreaming. What's your name?"}
	timer.start{ duration = 7, type = timer.simulate, callback = overrideScriptJiub02 } --Jiub
	timer.start{ duration = 8, type = timer.simulate, callback = overrideScriptWalkGuard01 } --guard
end

local function overrideScriptJiub00()
	timer.start{ duration = 1, type = timer.simulate, callback = overrideScriptJiub01 }
end

function this.chooseModeDefault()
	event.trigger("[CREL] mode chosen")
	event.trigger("[CREL] default mode chosen")
	--REWORK this once the feature gets added to MWSE
	--local region = tes3.findRegion("Bitter Coast Region")
	common.disableControls()

	for region in tes3.iterate(tes3.dataHandler.nonDynamicData.regions) do
		if (region.id == "Bitter Coast Region") then
			region:changeWeather(3)
		end
	end

	common.go(61, -135, 24, 340, "Imperial Prison Ship")

	overrideScriptJiub00()

	tes3.setGlobal("CharGenState", 10)

end

return this