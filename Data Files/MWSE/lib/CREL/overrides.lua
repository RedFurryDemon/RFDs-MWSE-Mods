local this = {}

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

local function CharGen_ring_keley()
	mwscript.stopScript{script="CharGen_ring_keley"}
end

local function CharGenWalkNPC()
	mwscript.stopScript{script="CharGenWalkNPC"}
end

local function CharGenStatsSheet()
	mwscript.stopScript{script="CharGenStatsSheet"}
end

local function CharGenRaceNPC()
	mwscript.stopScript{script="CharGenRaceNPC"}
end

local function CharGenDoorGuardTalker()
	mwscript.stopScript{script="CharGenDoorGuardTalker"}
end

local function CharGenDoorExit()
	mwscript.stopScript{script="CharGenDoorExit"}
end

local function CharGenClassNPC()
	mwscript.stopScript{script="CharGenClassNPC"}
end

local function CharGenBoatWomen()
	mwscript.stopScript{script="CharGenBoatWomen"}
end

local function CharGenBoatNPC()
	mwscript.stopScript{script="CharGenBoatNPC"}
end

--enabling anything still disabled
local function CharGenStuffRoom()
	common.enableControls()
	common.enableMenus()
	mwscript.stopScript{script="CharGenStuffRoom"}
end

function this.overrideScripts()
	mwse.overrideScript("CharGen", nukeDefaultChargen)
	mwse.overrideScript("CharGenNameNPC", nukeDefaultJiubIntro) --remember to override
	mwse.overrideScript("CharGen_ring_keley", CharGen_ring_keley) --remember to override
	mwse.overrideScript("CharGenBoatNPC", CharGenBoatNPC) --remember to override
	mwse.overrideScript("CharGenBoatWomen", CharGenBoatWomen) --remember to override
	mwse.overrideScript("CharGenClassNPC", CharGenClassNPC) --remember to override
	mwse.overrideScript("CharGenDoorExit", CharGenDoorExit) --remember to override
	mwse.overrideScript("CharGenDoorGuardTalker", CharGenDoorGuardTalker) --remember to override
	mwse.overrideScript("CharGenRaceNPC", CharGenRaceNPC) --remember to override
	mwse.overrideScript("CharGenStatsSheet", CharGenStatsSheet) --remember to override
	mwse.overrideScript("CharGenWalkNPC", CharGenWalkNPC) --remember to override
	mwse.overrideScript("CharGenCustomsDoor", CharGenCustomsDoor)
	mwse.overrideScript("CharGenJournalMessage", CharGenJournalMessage)
	mwse.overrideScript("CharGenBed", CharGenBed)
	mwse.overrideScript("CharGenDagger", CharGenDagger)
	mwse.overrideScript("CharGenDialogueMessage", CharGenDialogueMessage)
	mwse.overrideScript("CharGenDoorEnterCaptain", CharGenDoorEnterCaptain)
	mwse.overrideScript("CharGenDoorExitCaptain", CharGenDoorExitCaptain)
	mwse.overrideScript("CharGenFatigueBarrel", CharGenFatigueBarrel)
	mwse.overrideScript("CharGenStuffRoom", CharGenStuffRoom)
end

return this