return {
	--[[
		Notes on light source overrides:
		- base object ID MUST BE all lowercase
		- define any or all of the properties mentioned below (you can define different parametres for different lights)
		- remember about a comma at the end of every line with the properties, and after the "}"
	]]--
	overrideLightUser = {
		--put light overrides here, example:
		["light_example"] = {
			color = tes3vector3.new(240,135,50),
			radius = 256,
			time = -1,
			value = 3,
			weight = 0.2,
		},
		--[[["torch"] = {
			color = tes3vector3.new(0,0,250),
			radius = 1000,
			time = 10,
			value = 400,
			weight = 11,
		},]]--
		--next light override goes right here
	},
}