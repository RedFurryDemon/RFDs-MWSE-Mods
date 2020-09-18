	--[[
		Functions shared among chargen files.
	]]

local this = {}

--[[
	wrapper for PositionCell for convenience
]]

function this.go(xpos, ypos, zpos, zrot, destination)
	mwscript.positionCell{reference = tes3.mobilePlayer, cell = destination, x = xpos, y = ypos, z = zpos, rotation = zrot}
	tes3.messageBox("done") --debug, remove later
end

--[[
	this function iterates over spells in a table and adds them to the player when exiting chargen
	call like this: addStartSpells(mySpellTable)
	parameter must be a table; entry structure: ["rapid regenerate"] = true,
]]

function this.addStartSpells(spellTable)
	for addedSpell in pairs(spellTable) do
		mwscript.addSpell{
                reference = tes3.player,
                spell = addedSpell
		}
	end
end

--[[
	this function iterates over items in a table and adds them to the player when exiting chargen
	call like this: addStartItems(myItemTable)
	parameter must be a table; entry structure: ["misc_soulgem_grand"] = 5,
	the key is the item id, the value says how many of these items should be added
]]

function this.addStartItems(itemTable)
	for addedItem in pairs(itemTable) do
		mwscript.addItem{
                reference = tes3.player,
                item = addedItem,
                count = itemTable[addedItem]
        	}
	end
end

------------------
--ENABLING AND DISABLING
------------------

function this.toggleScripts()
	tes3.runLegacyScript{command = "ToggleScripts"}
end

local function setControls(state)
	local player = tes3.mobilePlayer
    player.controlsDisabled = state
    player.jumpingDisabled = state
    player.viewSwitchDisabled = state
    player.vanityDisabled = state
    player.attackDisabled = state
    player.magicDisabled = state
end

function this.disableControls()
	setControls(true)
end

function this.enableControls()
	setControls(false)
	tes3.messageBox("controls enabled")
end

function this.enableMenus()
	local menuController = tes3.worldController.menuController
    menuController.statsMenuEnabled = true
    menuController.magicMenuEnabled = true
    menuController.inventoryMenuEnabled = true
    menuController.mapMenuEnabled = true
	tes3.messageBox("menus enabled")
end


--[[
	final stuff that need to be done in EVERY chargen to set up the game correctly
]]

function this.setup()
	--enabling functions may be used multiple times, it's not necessary but won't cause a problem
	this.enableControls()
	this.enableMenus()
	mwscript.startScript({script = "RaceCheck"})
	tes3.setGlobal("CharGenState", -1)
end

return this