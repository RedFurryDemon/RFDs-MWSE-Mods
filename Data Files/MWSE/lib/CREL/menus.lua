	--[[
		Functions for creating menus, shared among chargen files.
	]]

local this = {}

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

--option is one clickable button
--optionTable is the table with options that should be buttons
--uiBlock is the block to create the list in
--uiID is the ID of the created list
--textVar is what is used to get the button text from

function this.createClickableList(option, optionTable, uiBlock, uiID, textVar, callback)
	for _, option in pairs(optionTable) do
        local button = uiBlock:createTextSelect{ id = tes3ui.registerID(uiID), text = textVar }
        button.autoHeight = true
        button.layoutWidthFraction = 1.0
        button.paddingAllSides = 2
        button.borderAllSides = 2
		button.borderRight = 0
        button:register("mouseClick", function() callback(option) end )
    end
end

--[[ (also shamelessly stolen from Merlord, but reworked to be more versatile)
    Sorts a table alphabetically.
    For notes, see the comments inside the function.
]]

function this.createSortedList(val, unsortedList, sortedList)
    local sort_func = function(a, b)
        -->examples of val: name, or id, or any valid field wth a string
		return string.lower(a[val]) < string.lower(b[val])
    end

	-->unsortedList example: classList
    for _, element in pairs(unsortedList) do
		-->sortedList example: this.sortedClassList
        table.insert(sortedList, element)
    end
    table.sort(sortedList, sort_func)

	return sortedList
end


------------------
--NAME MENU
------------------
this.pcName = ""

function this.setName()
	tes3.mobileplayer.name = this.pcName
end

--[[
	this function creates the menu for typing player name
	call like this: createMenuName(0.05, onNameSet, onNameTyped)
	delay is a number (in seconds) to the next action; calledFunction is the function to call after the name is set; setName is the function to use the typed text (most likely to set it as player name with setName, but you can use this to rename something else if you use a different function
]]

function this.createMenuName(delay, calledFunction)
--leaving this to Mer
local menuID = tes3ui.registerID("crelNameMenu")
	local function okayName()
		if (this.pcName == "") then
			tes3.messageBox("You need to enter a name.")
		else
			tes3ui.leaveMenuMode(menuID)
            tes3ui.findMenu(menuID):destroy()
			timer.start{ duration = delay, type = timer.simulate, callback = calledFunction }
		end
	end

	local function enterName()

		local menu = tes3ui.createMenu{ id = menuID, fixedFrame = true }
		menu.minWidth = 400
		menu.alignX = 0.5
		menu.alignY = 0
		menu.autoHeight = true

		mwse.mcm.createTextField(
			menu,
			{
				label = "Name",
				variable = mwse.mcm.createTableVariable{
					id = "pcName",
					table = this
					},
				callback = okayName
			})
		tes3ui.enterMenuMode(menuID)

	end
	enterName()
	tes3.messageBox("name: %s", this.pcName)
end

------------------
--WRAPPER FOR BIRTHSIGN MENU
------------------

--[[
	this function shows vanilla birthsign menu
	call like this: createMenuBirthsign(0.05, onChosenBirthsign)
	delay and calledFunction like in name functions
]]

function this.createMenuBirthsign(delay, calledFunction)
	tes3.runLegacyScript{command = "EnableBirthMenu"}
	timer.start{ duration = delay, type = timer.simulate, callback = calledFunction }
end

return this