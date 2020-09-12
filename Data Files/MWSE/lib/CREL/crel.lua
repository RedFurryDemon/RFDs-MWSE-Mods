local this = {}
local debug = true

------------------
--DEPENDENCIES
------------------

local common = require("CREL.common")
local menus = require("CREL.menus")
local sC = require("CREL.startCustom")
local sD = require("CREL.startDefault")
local sT = require("CREL.startTest")

------------------
--CHARGEN MODE SELECTION
------------------

--add entries to this table to make them show up during chargen mode selection

this.chargenModeList = {
    { text = "Custom", callback =  sC.chooseModeCustom},
	{ text = "Default", callback = sD.chooseModeDefault},
    { text = "Test", callback =  sT.chooseModeTest}
	}

local function chooseChargenMode()
	menus.messageBox({
            message = "Chargen Mode",
            buttons = this.chargenModeList
        })
end

------------------
--SETUP
------------------

function this.onLoaded(e)
	if (e.newGame == true) then
		event.trigger("[CREL] new game")
		if (debug) then tes3.messageBox("[CREL] loaded - new game") end
		mwse.log("[CREL] loaded - new game")
		timer.start{ duration = 1, type = timer.simulate, callback = chooseChargenMode }
	else
		if (debug) then tes3.messageBox("[CREL] loaded - existing save") end
	end
end

local function nukeDefaultChargen()
--set CharGenState to 10
	mwscript.stopScript{script="CharGen"}
end

local function nukeDefaultJiubIntro()
	mwscript.stopScript{script="CharGenNameNPC"}
end

local function CharGenCustomsDoor()
	mwscript.stopScript{script="CharGenCustomsDoor"}
end

local function CharGenBed()
	mwscript.stopScript{script="CharGenBed"}
end

local function CharGenJournalMessage()
	mwscript.stopScript{script="CharGenJournalMessage"}
end

local function CharGenDagger()
	mwscript.stopScript{script="CharGenDagger"}
end

local function CharGenDialogueMessage()
	mwscript.stopScript{script="CharGenDialogueMessage"}
end

local function CharGenDoorEnterCaptain()
	mwscript.stopScript{script="CharGenDoorEnterCaptain"}
end

--safety check for enabling stuff
local function CharGenDoorExitCaptain()
	common.enableControls()
	common.enableMenus()
	tes3.setGlobal("CharGenState", -1)
	mwscript.stopScript{script="CharGenDoorExitCaptain"}
end

local function CharGenFatigueBarrel()
	mwscript.stopScript{script="CharGenFatigueBarrel"}
end

--enabling anything still disabled
local function CharGenStuffRoom()
	common.enableControls()
	common.enableMenus()
	mwscript.stopScript{script="CharGenStuffRoom"}
end

function this.initializeFramework()
	event.register("loaded", this.onLoaded)
	mwse.overrideScript("CharGen", nukeDefaultChargen)
	--mwse.overrideScript("CharGenNameNPC", nukeDefaultJiubIntro)
	mwse.overrideScript("CharGenCustomsDoor", CharGenCustomsDoor)
	mwse.overrideScript("CharGenJournalMessage", CharGenJournalMessage)
	mwse.overrideScript("CharGenBed", CharGenBed)
	mwse.overrideScript("CharGenDagger", CharGenDagger)
	mwse.overrideScript("CharGenDialogueMessage", CharGenDialogueMessage)
	mwse.overrideScript("CharGenDoorEnterCaptain", CharGenDoorEnterCaptain)
	mwse.overrideScript("CharGenDoorExitCaptain", CharGenDoorExitCaptain)
	mwse.overrideScript("CharGenFatigueBarrel", CharGenFatigueBarrel)
	mwse.overrideScript("CharGenStuffRoom", CharGenStuffRoom)
	if (debug) then tes3.messageBox("[CREL] initialized") end
	mwse.log("[CREL] initialized")
end

return this