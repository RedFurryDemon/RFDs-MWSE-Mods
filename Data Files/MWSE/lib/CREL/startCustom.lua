local this = {}
local menus = require("CREL.menus")
local menuB = require("CREL.menuBeginnings")
local menuC = require("CREL.menuClasses")
local common = require("CREL.common")

--local ccng = include("Aleist3r.Character Creation Name Generator.MenuNameGenerator")

--yes I am keeping this HERE because otherwise I'd probably forget
--[[
	local gh_interop = include("graphicHerbalism.interop")
function gh_interop.getFailureString(container)
  return string.format("whatever custom failure text %s", container)
end


local gh_config = include("graphicHerbalism.config")
if gh_config then
  gh_config.blacklist["my object id"] = true
end]]


local debug = true

--the logging functions are used to assess chargen state and prevent overlapping

local function stageFourDone()
tes3.player.baseObject.name = menus.pcName
	--tes3.setGlobal()
	if (debug) then tes3.messageBox("name: %s", menus.pcName) end
	mwse.log("[CREL] custom mode - player name: %s", menus.pcName)
	menuC.createClassMenu()
	--menus.createOptionsMenu()
	--menuB.createBeginningMenu()
end

local function stageThreeDone()
	if (debug) then tes3.messageBox("[CREL] custom mode - something happened") end
	mwse.log("[CREL] custom mode - something happened")
	--menus.createClassMenu()
	menus.createMenuName(0.1, stageFourDone)
	--ccng.showNameGenerationMenu()
end

--[[local function customMenuClass()
local pcName
local setNameFunction = menus.setName(pcName)
	--tes3.runLegacyScript{command = "EnableClassMenu"}
	--timer.start{ duration = 0.05, type = timer.simulate, callback = customMenuName }
	tes3.messageBox("DEBUG: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
	menus.createMenuName(0.05, postNameFunction, setNameFunction)
end]]

--NAME

local function stageTwoDone()
	if (debug) then tes3.messageBox("[CREL] custom mode - birthsign set") end
	mwse.log("[CREL] custom mode - birthsign set")
	--menus.createMenuName(0.2, stageThreeDone, nameisset)
	stageThreeDone()
end

--BIRTHSIGN

local function stageOneDone()
	if (debug) then tes3.messageBox("[CREL] custom mode - race set") end
	mwse.log("[CREL] custom mode - race set")
	menus.createMenuBirthsign(0.1, stageTwoDone)
end

--RACE

function this.chooseModeCustom()
	event.trigger("[CREL] custom mode chosen")
	mwse.log("[CREL] beginning set to custom")
	--tes3.runLegacyScript{command = "coc Balmora"}
	tes3.runLegacyScript{command = "EnableRaceMenu"}
	timer.start{ duration = 0.1, type = timer.simulate, callback = stageOneDone }
end

return this