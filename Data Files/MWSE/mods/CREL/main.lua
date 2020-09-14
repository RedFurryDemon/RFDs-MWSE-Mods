local crel = require("CREL.crel")

--note: all of these MUST be appropriate for ANY vanilla race or origin
local defaultItemSet = {
	["gold_001"] = 25,
	["torch"] = 1,
	["ingred_bread_01"] = 2
}

local crelStartDefaultBoat = {
	id = "crelStartDefaultBoat",
	title = "Arrived by boat",
	items = defaultItemSet,
	locations = {
		loc1 = {-9029, -73010, 103, -44, "Seyda Neen"},
		loc2 = {-69216, 141779, 222, -176, "Khuul"},
		},
}

local crelStartDefaultCity = {
	id = "crelStartDefaultCity",
	title = "Entering a city",
	items = defaultItemSet,
	locations = {
		loc1 = {30292, -74390, 543, -159, "Vivec, Foreign Quarter"},
		loc2 = {-18751, 52268, 1632, 73, "Ald-ruhn"},
		loc3 = {-22296, -18947, 369, -13, "Balmora"},
		},
}

local crelStartDefaultTavern = {
	id = "crelStartDefaultTavern",
	title = "Resting in a tavern",
	items = defaultItemSet,
	locations = {
		loc1 = {501, 824, -239, -41, "Balmora, Eight Plates"},
		loc2 = {-115, -1207, -488, 78, "Ald-ruhn, Ald Skar Inn"},
		loc3 = {210, 521, 12, -168, "Ebonheart, Six Fishes"},
		},
}

local defaultBeginnings = {
	crelStartDefaultBoat,
	crelStartDefaultCity,
	crelStartDefaultTavern
}

local function onInitialized()
	crel.initializeFramework()
	event.register("[CREL] custom mode chosen", crel.registerBeginnings(defaultBeginnings))
end

event.register("initialized", onInitialized)