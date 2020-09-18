local this = {}

local function nukeDefaultChargen()
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

local function CharGenDoorExitCaptain()
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

local function CharGenStuffRoom()
	mwscript.stopScript{script="CharGenStuffRoom"}
end

function this.overrideScripts()
	mwse.overrideScript("CharGen", nukeDefaultChargen)
	mwse.overrideScript("CharGenNameNPC", nukeDefaultJiubIntro)
	mwse.overrideScript("CharGen_ring_keley", CharGen_ring_keley)
	mwse.overrideScript("CharGenBoatNPC", CharGenBoatNPC)
	mwse.overrideScript("CharGenBoatWomen", CharGenBoatWomen)
	mwse.overrideScript("CharGenClassNPC", CharGenClassNPC)
	mwse.overrideScript("CharGenDoorExit", CharGenDoorExit)
	mwse.overrideScript("CharGenDoorGuardTalker", CharGenDoorGuardTalker)
	mwse.overrideScript("CharGenRaceNPC", CharGenRaceNPC)
	mwse.overrideScript("CharGenStatsSheet", CharGenStatsSheet)
	mwse.overrideScript("CharGenWalkNPC", CharGenWalkNPC)
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