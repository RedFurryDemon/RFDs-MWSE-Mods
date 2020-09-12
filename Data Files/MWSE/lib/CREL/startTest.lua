	--[[
		Functions for the setup of almost-instant chargen for playtesting.
	]]
local this = {}
local common = require("CREL.common")

------------------
--ADDING ITEMS AND SPELLS
------------------

local testItems = {
	["torch"] = 5,
	["gold_001"] = 1000,
	["misc_soulgem_grand"] = 10,
	["silver arrow"] = 100,
	["silver longsword"] = 1,
	["bonemold long bow"] = 1,
	}


local testSpells = {
		["almsivi intervention"] = true,
		["recall"] = true,
		["detect creature"] = true,
		["dispel"] = true,
		["divine intervention"] = true,
		["mark"] = true,
		["soul trap"] = true,
		["telekinesis"] = true,
		["strong levitate"] = true,
		["strong open"] = true,
		["slowfall"] = true,
		["swimmer's blessing"] = true,
		["vivec's kiss"] = true,
		["water walking"] = true,
		["charming touch"] = true,
		["concealment"] = true,
		["chameleon"] = true,
		["night eye"] = true,
		["summon scamp"] = true,
		["summon golden saint"] = true,
		["cure common disease"] = true,
		["cure blight disease"] = true,
		["cure poison"] = true,
		["rapid regenerate"] = true,
	}

------------------
--STATS AND ATTRIBUTES TO 100, HMF TO 5000
------------------

local function setTestStats()

	local skillTable = tes3.mobilePlayer.skills
	for skillNumber in ipairs(skillTable) do
		tes3.setStatistic({
			reference = tes3.mobilePlayer,
			skill = skillNumber - 1,
			current = 100
		})
	end

	local attrTable = tes3.mobilePlayer.attributes
	for attrNumber in ipairs(attrTable) do
		tes3.setStatistic({
			reference = tes3.mobilePlayer,
			attribute = attrNumber - 1,
			current = 100
		})
	end
	
	tes3.setStatistic({
		reference = tes3.mobilePlayer,
		name = "health",
		value = 5000
	})
	tes3.setStatistic({
		reference = tes3.mobilePlayer,
		name = "magicka",
		value = 5000
	})
	tes3.setStatistic({
		reference = tes3.mobilePlayer,
		name = "fatigue",
		value = 5000
	})
end

------------------
--MAIN FUNCTION
------------------

function this.chooseModeTest()
	event.trigger("[CREL] mode chosen")
	event.trigger("[CREL] test mode chosen")
	--tes3.messageBox("currently disabled")
	setTestStats()
	tes3.player.baseObject.name = "Not Outlander" --I refuse to use anything else
	common.addStartItems(testItems)
	common.addStartSpells(testSpells)
	common.go(-23065, -15358, 593, 200, "Balmora")
	common.setup()
	mwse.log("[CREL] beginning set to test")
end

return this