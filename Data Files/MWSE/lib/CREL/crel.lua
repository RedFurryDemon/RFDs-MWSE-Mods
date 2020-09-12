local this = {}
local debug = true

------------------
--DEPENDENCIES
------------------

this.common = require("CREL.common")
this.menus = require("CREL.menus")
this.startCustom = require("CREL.startCustom")
this.startDefault = require("CREL.startDefault")
this.startTest = require("CREL.startTest")

local common = this.common
local menus = this.menus
local sC = this.startCustom
local sD = this.startDefault
local sT = this.startTest

------------------
--CHARGEN MODE SELECTION
------------------

--add entries to this table to make them show up during chargen mode selection

this.chargenModeList = {
    { text = "Custom", callback =  sC.chooseModeCustom},
	--{ text = "Default", callback = sD.chooseModeDefault},
    { text = "Test", callback =  sT.chooseModeTest}
	}

local function chooseChargenMode()
	common.messageBox({
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
	end
	if (debug) then tes3.messageBox("[CREL] loaded") end
	timer.start{ duration = 1, type = timer.simulate, callback = chooseChargenMode }
end

local function nukeDefaultChargen()
--set CharGenState to 10
	mwscript.stopScript{script="CharGen"}
end

local function nukeDefaultJiubIntro()
	mwscript.stopScript{script="CharGenNameNPC"}
end

local function nukeDefaultTrapdoor()
	mwscript.stopScript{script="CharGenCustomsDoor"}
end

function this.initializeFramework()
	event.register("loaded", this.onLoaded)
	mwse.overrideScript("CharGen", nukeDefaultChargen)
	mwse.overrideScript("CharGenNameNPC", nukeDefaultJiubIntro)
	mwse.overrideScript("CharGenCustomsDoor", nukeDefaultTrapdoor)
	if (debug) then tes3.messageBox("[CREL] initialized") end
	mwse.log("[CREL] initialized")
end

return this