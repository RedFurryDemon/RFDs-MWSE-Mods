return {
	--[[
		Notes on cell overrides:
		- cell name MUST BE all lowercase
		- define all three colors, and in the same order as in the example (ambient, fog, sun)
		- remember about a comma at the end of every line with the colors, and after the "}"
	]]--
	overrideTableUser = {
		--put cell overrides here, example:
		["test cell"] = {
			ambientColor = tes3vector3.new(20,20,35),
			fogColor = tes3vector3.new(25,25,35),
			sunColor = tes3vector3.new(15,15,25),
		},
		--[[["balmora, dralasa nithryon: pawnbroker"] = {
			ambientColor = tes3vector3.new(0,255,0),
			fogColor = tes3vector3.new(75,50,24),
			sunColor = tes3vector3.new(0,0,0),
		},
		["balmora, ra'virr: trader"] = {
			ambientColor = tes3vector3.new(20,20,170),
			fogColor = tes3vector3.new(66,50,187),
			sunColor = tes3vector3.new(40,20,183),
		},]]
		--next cell override goes right here
	},
}