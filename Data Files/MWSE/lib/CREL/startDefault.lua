local this = {}
local common = require("CREL.common")

function this.chooseModeDefault()

	--set weather to thunderstorm
	--REWORK this once the feature gets added to MWSE
	--local region = tes3.findRegion("Bitter Coast Region")
	common.disableControls()

	for region in tes3.iterate(tes3.dataHandler.nonDynamicData.regions) do
		if (region.id == "Bitter Coast Region") then
			region:changeWeather(3)
		end
	end

	common.go(61, -135, 24, 340, "Imperial Prison Ship")

	tes3.setGlobal("CharGenState", 10)

end

return this