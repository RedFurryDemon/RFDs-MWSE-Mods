local crel = require("CREL.crel")

--note: nuke this later
local defaultItemSet = {
	["gold_001"] = 25,
	["torch"] = 1,
	["ingred_bread_01"] = 2
}

--[[
local crelStart001 = {
	title = "Arrived by boat",
	items = {},
	spells = {},
	blockItems = false,
	blockSpells = false,
	dependencies = {}, --mods needed for this
	requirements = {}, -- player faction/race/etc.
	locations = {
		loc1 = {},
		loc2 = {},
		loc2 = {},
		},
	callback = start001Function
}
	]]

local crelStartSurvivalShore = {
	id = "crelStartSurvivalShore",
	title = "Washed ashore",
	items = {},
	spells = {},
	blockItems = false,
	blockSpells = false,
	dependencies = {}, --mods needed for this
	requirements = {}, -- player faction/race/etc.
	locations = {
		loc1 = {},
		loc2 = {},
		loc3 = {},
		},
	callback = start001Function
}

local crelStartSurvivalWreck = {
	id = "crelStartSurvivalWreck",
	title = "Shipwrecked",
	items = {},
	spells = {},
	blockItems = false,
	blockSpells = false,
	dependencies = {}, --mods needed for this
	requirements = {}, -- player faction/race/etc.
	locations = {
		loc1 = {},
		loc2 = {},
		loc3 = {},
		},
	callback = start001Function
}

local crelStartSurvivalDrowning = {
	id = "crelStartSurvivalDrowning",
	title = "Drowning",
	items = {},
	spells = {},
	blockItems = false,
	blockSpells = false,
	dependencies = {}, --mods needed for this
	requirements = {}, -- player faction/race/etc.
	locations = {
		loc1 = {},
		loc2 = {},
		loc3 = {},
		},
	callback = start001Function
}

local crelStartSurvivalFreezing = {
	id = "crelStartSurvivalFreezing",
	title = "Freezing in the mountains",
	items = {},
	spells = {},
	blockItems = false,
	blockSpells = false,
	dependencies = {}, --mods needed for this
	requirements = {}, -- player faction/race/etc.
	locations = {
		loc1 = {},
		loc2 = {},
		loc3 = {},
		},
	callback = start001Function
}

local crelStartSurvivalAshland = {
	id = "crelStartSurvivalAshland",
	title = "Lost in the ashen wastes",
	items = {},
	spells = {},
	blockItems = false,
	blockSpells = false,
	dependencies = {}, --mods needed for this
	requirements = {}, -- player faction/race/etc.
	locations = {
		loc1 = {},
		loc2 = {},
		loc3 = {},
		},
	callback = start001Function
}

local crelStartSurvivalCamping = {
	id = "crelStartSurvivalCamping",
	title = "Camping in the wilderness",
	items = {},
	spells = {},
	blockItems = false,
	blockSpells = false,
	dependencies = {}, --mods needed for this
	requirements = {}, -- player faction/race/etc.
	locations = {
		loc1 = {},
		loc2 = {},
		loc3 = {},
		},
	callback = start001Function
}

local crelStartFactionHHCurio = {
	id = "crelStartFactionHHCurio",
	title = "Entertaining Crassius Curio",
	items = {},
	spells = {},
	blockItems = false,
	blockSpells = false,
	dependencies = {}, --mods needed for this
	requirements = {}, -- player faction/race/etc.
	locations = {
		loc1 = {},
		loc2 = {},
		loc3 = {},
		},
	callback = start001Function
}

local crelStartFactionHIVelks = {
	id = "crelStartFactionHIVelks",
	title = "Watching over a velk herd",
	items = {},
	spells = {},
	blockItems = false,
	blockSpells = false,
	dependencies = {}, --mods needed for this
	requirements = {}, -- player faction/race/etc.
	locations = {
		loc1 = {},
		loc2 = {},
		loc3 = {},
		},
	callback = start001Function
}

local crelStartFactionHDrOverseer = {
	id = "crelStartFactionHDrOverseer",
	title = "Overseeing slaves",
	items = {},
	spells = {},
	blockItems = false,
	blockSpells = false,
	dependencies = {}, --mods needed for this
	requirements = {}, -- player faction/race/etc.
	locations = {
		loc1 = {},
		loc2 = {},
		loc3 = {},
		},
	callback = start001Function
}

local crelStartFactionHDgPray = {
	id = "crelStartFactionHDgPray",
	title = "Worshipping Lord Dagoth",
	items = {},
	spells = {},
	blockItems = false,
	blockSpells = false,
	dependencies = {}, --mods needed for this
	requirements = {}, -- player faction/race/etc.
	locations = {
		loc1 = {},
		loc2 = {},
		loc3 = {},
		},
	callback = start001Function
}

local crelStartFactionEECEbony = {
	id = "crelStartFactionEECEbony",
	title = "Transporting ebony",
	items = {},
	spells = {},
	blockItems = false,
	blockSpells = false,
	dependencies = {}, --mods needed for this
	requirements = {}, -- player faction/race/etc.
	locations = {
		loc1 = {},
		loc2 = {},
		loc3 = {},
		},
	callback = start001Function
}

local crelStartFactionILDuty = {
	id = "crelStartFactionILDuty",
	title = "On duty",
	items = {},
	spells = {},
	blockItems = false,
	blockSpells = false,
	dependencies = {}, --mods needed for this
	requirements = {}, -- player faction/race/etc.
	locations = {
		loc1 = {},
		loc2 = {},
		loc3 = {},
		},
	callback = start001Function
}

local crelStartFactionFGPests = {
	id = "crelStartFactionFGPests",
	title = "Exterminating pests",
	items = {},
	spells = {},
	blockItems = false,
	blockSpells = false,
	dependencies = {}, --mods needed for this
	requirements = {}, -- player faction/race/etc.
	locations = {
		loc1 = {},
		loc2 = {},
		loc3 = {},
		},
	callback = start001Function
}

local crelStartFactionMGDwemer = {
	id = "crelStartFactionMGDwemer",
	title = "Recovering Dwemer artifacts",
	items = {},
	spells = {},
	blockItems = false,
	blockSpells = false,
	dependencies = {}, --mods needed for this
	requirements = {}, -- player faction/race/etc.
	locations = {
		loc1 = {},
		loc2 = {},
		loc3 = {},
		},
	callback = start001Function
}

local survivalBeginnings = {
	crelStartSurvivalShore,
	crelStartSurvivalWreck,
	crelStartSurvivalDrowning,
	crelStartSurvivalFreezing,
	crelStartSurvivalAshland,
	crelStartSurvivalCamping
}

local factionBeginnings = {
	crelStartFactionHHCurio,
	crelStartFactionHIVelks,
	crelStartFactionHDrOverseer,
	crelStartFactionHDgPray,
	crelStartFactionEECEbony,
	crelStartFactionILDuty,
	crelStartFactionFGPests,
	crelStartFactionMGDwemer
}

local function onInitialized()
	event.register("[CREL] custom mode chosen", function ()
    	crel.registerBeginnings(survivalBeginnings)
		crel.registerBeginnings(factionBeginnings)
	end)
end

event.register("initialized", onInitialized)