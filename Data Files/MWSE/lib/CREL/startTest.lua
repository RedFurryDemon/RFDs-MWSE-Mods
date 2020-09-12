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

--temporary function to move, get a better one

local function testMove()
	tes3.runLegacyScript{command = "coc Balmora"}
end

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
		mwse.log("[CREL] modified skill: %.0f", skillNumber)
	end

	local attrTable = tes3.mobilePlayer.attributes
	for attrNumber in ipairs(attrTable) do
		tes3.setStatistic({
			reference = tes3.mobilePlayer,
			attribute = attrNumber - 1,
			current = 100
		})
		mwse.log("[CREL] modified attribute: %.0f", attrNumber)
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

	tes3.messageBox("currently disabled")
	--[[setTestStats()
	common.addStartItems(testItems)
	common.addStartSpells(testSpells)
	common.enableControls()
	common.enableMenus()
	testMove()
	mwse.log("[CREL] beginning set to test")]]
end

return this