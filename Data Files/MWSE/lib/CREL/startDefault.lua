local this = {}
local common = require("CREL.common")
local menus = require("CREL.menus")

local trapdoorTimer
local ergallaTimer

--joke's on you: this chain of functions doesn't override any vanilla script; instead, it recreates interactions in lua... because reasons, I suppose

local function overrideEnd()
	tes3.unlock{reference = "chargen door hall"}
	tes3.messageBox("Holy fuck, this works.")
end

-- Ergalla also needs disable/enable player controls!

local function overrideScriptErgalla08()
	tes3.say{reference = "chargen class", soundPath = "vo\\Misc\\CharGen Class4.wav", subtitle = "Take your papers off the table and go see Captain Gravius."}
	timer.start{ duration = 8, type = timer.simulate, callback = overrideEnd }
end

local function overrideScriptErgalla07()
	tes3.say{reference = "chargen class", soundPath = "vo\\Misc\\CharGen Class3.wav", subtitle = "Show your papers to the Captain when you exit to get your release fee."}
	--timer.start{ duration = 8, type = timer.simulate, callback = overrideScriptErgalla08 }
	timer.start{ duration = 8, type = timer.simulate, callback = overrideEnd }
end

local function overrideScriptErgalla06()
	tes3.addItem{reference = tes3.mobilePlayer, item = "CharGen StatsSheet"}
	timer.start{ duration = 0.5, type = timer.simulate, callback = overrideScriptErgalla07 }
end

local function overrideScriptErgalla05()
	tes3.say{reference = "chargen class", soundPath = "vo\\Misc\\CharGen Class2.wav", subtitle = "Interesting. Now before I stamp these papers, make sure this information is correct."}
	timer.start{ duration = 7, type = timer.simulate, callback = overrideScriptErgalla06 }
end

local function overrideScriptErgalla04()
	tes3.runLegacyScript{command = "EnableBirthMenu"}
	timer.start{ duration = 1, type = timer.simulate, callback = overrideScriptErgalla05 }
end

local function overrideScriptErgalla03()
	tes3.say{reference = "chargen class", soundPath = "vo\\Misc\\CharGen Birth.wav", subtitle = "Very good. The letter that preceded you mentioned you were born under a certain sign. And what would that be?"}
	timer.start{ duration = 7, type = timer.simulate, callback = overrideScriptErgalla04 }
end

local function overrideScriptErgalla02()
	tes3.runLegacyScript{command = "EnableClassMenu"}
	timer.start{ duration = 1, type = timer.simulate, callback = overrideScriptErgalla03 }
end

local function overrideScriptErgalla01()
	if (mwscript.getDistance({ reference = "chargen class", target = tes3.mobilePlayer }) <= 100 ) then
		ergallaTimer:cancel()
		-- needs an "onActivate" version as well
		tes3.say{reference = "chargen class", soundPath = "vo\\Misc\\CharGen Class1.wav", subtitle = "Ahh yes, we've been expecting you. You'll have to be recorded before you're officially released. There are a few ways we can do this, and the choice is yours."}
		timer.start{ duration = 12, type = timer.simulate, callback = overrideScriptErgalla02 }
	end
end


local function overrideScriptErgalla00()
	ergallaTimer = timer.start{ duration = 0.25, type = timer.simulate, callback = overrideScriptErgalla01, iterations = -1 }
	mwscript.disable{reference = "CharGen StatsSheet"}
	mwscript.disable{reference = "CharGen Boat"}
	mwscript.disable{reference = "CharGen Boat Guard 1"}
	mwscript.disable{reference = "CharGen Boat Guard 2"}
	mwscript.disable{reference = "CharGen Dock Guard"}
	mwscript.disable{reference = "CharGen_cabindoor"}
	mwscript.disable{reference = "CharGen_chest_02_empty"}
	mwscript.disable{reference = "CharGen_crate_01"}
	mwscript.disable{reference = "CharGen_crate_01_empty"}
	mwscript.disable{reference = "CharGen_crate_01_misc01"}
	mwscript.disable{reference = "CharGen_crate_02"}
	mwscript.disable{reference = "CharGen_lantern_03_sway"}
	mwscript.disable{reference = "CharGen_ship_trapdoor"}
	mwscript.disable{reference = "CharGen_barrel_01"}
	mwscript.disable{reference = "CharGen_barrel_02"}
	mwscript.disable{reference = "CharGenbarrel_01_drinks"}
	mwscript.disable{reference = "CharGen_plank"}
	event.unregister("cellChanged", overrideScriptErgalla00)
end

local function overrideScriptBoatGuard07()
	if (mwscript.getDistance({ reference = "chargen dock guard", target = tes3.mobilePlayer }) <= 150 ) then
		tes3.say{reference = "chargen dock guard", soundPath = "vo\\Misc\\CharGenDock3.wav", subtitle = "Head on in."}
		--timer.start{ duration = 6, type = timer.simulate, callback = overrideScriptErgalla01 }
	end
end

local function overrideScriptBoatGuard06()
	tes3.setAITravel{ reference = "chargen dock guard", destination = {-9944, -72481, 126}}
	timer.start{ duration = 10, type = timer.simulate, callback = overrideScriptBoatGuard07 }
end

local function overrideScriptBoatGuard05()
	tes3.say{reference = "chargen dock guard", soundPath = "Vo\\Misc\\CharGenDock2.wav", subtitle = "Great. I'm sure you'll fit right in. Follow me up to the office and they'll finish your release."}
	tes3.runLegacyScript{command = "EnablePlayerControls"}
	event.register("cellChanged", overrideScriptErgalla00) --foolproof it to specific cell?
	timer.start{ duration = 5, type = timer.simulate, callback = overrideScriptBoatGuard06 }
end

local function overrideScriptBoatGuard04()
	tes3.runLegacyScript{command = "EnableRaceMenu"}
	timer.start{ duration = 1.5, type = timer.simulate, callback = overrideScriptBoatGuard05 }
end

--[[local function overrideScriptBoatGuard03()
	tes3.say{reference = "chargen dock guard", soundPath = "Vo\\Misc\\CharGenDock1.wav", subtitle = "You finally arrived, but our records don't show from where."}
	timer.start{ duration = 5, type = timer.simulate, callback = overrideScriptBoatGuard04 }
end]]

local function overrideScriptBoatGuard02()
	tes3.say{reference = "chargen dock guard", soundPath = "Vo\\Misc\\CharGenDock1.wav", subtitle = "You finally arrived, but our records don't show from where."}
	tes3.runLegacyScript{command = "DisablePlayerControls"}
	timer.start{ duration = 5, type = timer.simulate, callback = overrideScriptBoatGuard04 }
end

local function overrideScriptBoatGuard01()
	if (trapdoorTimer) then
		trapdoorTimer:cancel()
	end
	event.unregister("cellChanged", overrideScriptBoatGuard01)
	tes3.setAITravel{ reference = "chargen dock guard", destination = {-8914, -73093, 126}}
	timer.start{ duration = 10, type = timer.simulate, callback = overrideScriptBoatGuard02 }
end

local function overrideScriptBoatGuard00()
	--event.unregister("cellChanged", overrideScriptBoatGuard00)
	timer.start{ duration = 6, type = timer.simulate, callback = overrideScriptBoatGuard01 }
end

local function overrideScriptWalkGuard06()
	tes3.say{reference = "chargen boat guard 2", soundPath = "vo\\Misc\\CharGenWalk3.wav", subtitle = "On deck now, prisoner."}
	--this needs to be unfucked - swap timer for event
	--unfucked now?
	--timer.start{ duration = 3, type = timer.simulate, callback = overrideScriptBoatGuard01 }
end

local function overrideScriptWalkGuard05()
	local distance = mwscript.getDistance({ reference = "chargen boat guard 2", target = "chargen_shipdoor" })
	tes3.messageBox("%.2f", distance)
	if (distance <= 315) then
		if (trapdoorTimer) then
			trapdoorTimer:cancel()
		end
		tes3.setAITravel{ reference = "chargen boat guard 2", destination = {185, 174, 170}}
		tes3.say{reference = "chargen boat guard 2", soundPath = "Vo\\Misc\\CharGenWalk2.wav", subtitle = "Get yourself up on deck, and let's keep this as civil as possible."}
		timer.start{ duration = 6, type = timer.simulate, callback = overrideScriptWalkGuard06 }
	end
end

local function overrideScriptWalkGuard04()
	event.register("cellChanged", overrideScriptBoatGuard01)
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
	--tes3.setStatistic{attribute = 4, reference = "chargen boat guard 2", value = 60}
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
	timer.start{ duration = 10, type = timer.simulate, callback = overrideScriptJiub04 }
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

	--overcast (for nice looks)
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