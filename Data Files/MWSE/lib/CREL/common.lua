	--[[
		Functions shared among chargen files.
	]]

local this = {}

--[[
	this function iterates over spells in a table and adds them to the player when exiting chargen
	call like this: addStartSpells(mySpellTable)
	parameter must be a table; entry structure: ["rapid regenerate"] = true,
]]

local spellTable = {}
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

local itemTable = {}
function this.addStartItems(itemTable)
	for addedItem in pairs(itemTable) do
		mwscript.addItem{
                reference = tes3.player, 
                item = addedItem,
                count = itemTable[addedItem]
        	}
	end
end

--[[ (shamelessly stolen from Merlord)
    Allows the creation of messageboxes using buttons that each have their own callback.
    {
        message = "Message",
        buttons = [
            { text = "Button text", callback = function }
        ]
    }
]]

function this.messageBox(params)
    local message = params.message
    local buttons = params.buttons
    local function callback(e)
        --get button from 0-indexed MW param
        local button = buttons[e.button+1]
        if button.callback then
            button.callback()
        end
    end
    --Make list of strings to insert into buttons
    local buttonStrings = {}
    for _, button in ipairs(buttons) do
        table.insert(buttonStrings, button.text)
    end
    tes3.messageBox({
        message = message,
        buttons = buttonStrings,
        callback = callback
    })
end

------------------
--ENABLING AND DISABLING
------------------

function this.toggleScripts()
	tes3.runLegacyScript{command = "ToggleScripts"}
end

function this.disableControls()
	tes3.runLegacyScript{command = "DisablePlayerControls"}
	tes3.runLegacyScript{command = "DisablePlayerJumping"}
	tes3.runLegacyScript{command = "DisablePlayerViewSwitch"}
	tes3.runLegacyScript{command = "DisableVanityMode"}
	tes3.runLegacyScript{command = "DisablePlayerFighting"}
	tes3.runLegacyScript{command = "DisablePlayerMagic"}
end

function this.disableMenus()
	tes3.runLegacyScript{command = "disableInventoryMenu"}
	tes3.runLegacyScript{command = "disableMagicMenu"}
	tes3.runLegacyScript{command = "disableMapMenu"}
	tes3.runLegacyScript{command = "disableStatsMenu"}
end

function this.enableControls()
	tes3.runLegacyScript{command = "EnablePlayerViewSwitch"}
	tes3.runLegacyScript{command = "EnablePlayerControls"}
	tes3.runLegacyScript{command = "EnablePlayerLooking"}
	tes3.runLegacyScript{command = "EnablePlayerFighting"}
	tes3.runLegacyScript{command = "EnablePlayerJumping"}
	tes3.runLegacyScript{command = "EnablePlayerMagic"}
	tes3.runLegacyScript{command = "EnableInventoryMenu"}
end

function this.enableMenus()
	tes3.runLegacyScript{command = "EnableStatsMenu"}
	tes3.runLegacyScript{command = "EnableMagicMenu"}
	tes3.runLegacyScript{command = "EnableInventoryMenu"}
	tes3.runLegacyScript{command = "EnableMapMenu"}
end

function this.testMove()
	tes3.runLegacyScript{command = "coc Balmora"}
end


local pcName

function this.setName()
	tes3.mobileplayer.name = pcName
end

function this.customMenuName()
	--tes3.runLegacyScript{command = "EnableNameMenu"}
local menuID = tes3ui.registerID("crelNameMenu")
                local menu = tes3ui.createMenu{ id = menuID, fixedFrame = true }
                menu.minWidth = 400
                menu.alignX = 0.5
                menu.alignY = 0
                menu.autoHeight = true
               -- menu.widthProportional = 1
                --menu.heightProportional = 1
                mwse.mcm.createTextField(
                    menu,
                    {
                        label = "Name",
                        variable = pcName,
                        callback = setName
                    }
                )
                tes3ui.enterMenuMode(menuID)
				timer.start{ duration = 0.05, type = timer.simulate, callback = enableAll }
end


function this.menuBirthsign(delay, calledFunction)
	tes3.runLegacyScript{command = "EnableBirthMenu"}
	timer.start{ duration = delay, type = timer.simulate, callback = calledFunction }
end

------------------
--VANILLA SCRIPT NUKING
------------------

local function nukeDefaultChargen()
--set CharGenState to 10
	mwscript.stopScript{script="CharGen"}
end

local function nukeDefaultJiubIntro()
	mwscript.stopScript{script="CharGenNameNPC"}
end

local function nukeDefaultTrapdoor()
	mwscript.stopScript{script="CharGenCustomsDoor"}
end

return this