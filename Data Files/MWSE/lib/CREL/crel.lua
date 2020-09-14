local this = {}
local debug = true

------------------
--DEPENDENCIES
------------------

local common = require("CREL.common")
local overrides = require("CREL.overrides")
local menus = require("CREL.menus")
local menuB = require("CREL.menuBeginnings")
local sC = require("CREL.startCustom")
local sD = require("CREL.startDefault")
local sT = require("CREL.startTest")

function this.registerBeginnings(beginnings)
	menuB.registerBeginnings(beginnings)
end

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

function this.initializeFramework()
	event.register("loaded", this.onLoaded)
	overrides.overrideScripts()
	if (debug) then tes3.messageBox("[CREL] initialized") end
	mwse.log("[CREL] initialized")
end

return this