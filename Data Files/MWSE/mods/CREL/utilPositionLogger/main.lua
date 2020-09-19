local function savePlayerPosition()
--todo: add a check if player exists
--also make it work only in test mode? and change keybind

	local xpos = tes3.mobilePlayer.position.x
	local ypos = tes3.mobilePlayer.position.y
	--adding 10 in case of funky collision; this won't fuck up the positioning function
	local zpos = tes3.mobilePlayer.position.z + 10
	local zrot = math.deg(tes3.player.orientation.z)
	--local zrot = tes3.player.orientation.z * 100
	--local zrot = tes3.runLegacyScript{ command = "player->getangle, z"}
	local destination = tes3.getPlayerCell().id
	--floating-point values can be used for CREL positioning function, but honestly I see no need to include them here
	mwse.log('[CREL] Current position: (%.0f, %.0f, %.0f, %.0f, "%s")', xpos, ypos, zpos, zrot, destination)
	tes3.messageBox('[CREL] Current position:\nx %.0f,\ny %.0f,\nz %.0f,\nrotation %.0f,\n"%s"', xpos, ypos, zpos, zrot, destination)
end

local function initialized()
	event.register("keyDown", savePlayerPosition, {filter = tes3.scanCode.p})
end

event.register("initialized", initialized)