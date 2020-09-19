	--[[
		Functions for creating alt start scenario menu.
	]]

local this = {}

local menus = require("CREL.menus")
local common = require("CREL.common")

local function doStuff()
tes3.messageBox("aaa")
mwse.log("[CREL TEST] callback called")
end

local startMenuID = tes3ui.registerID("crelStartMenu")
local rightBlockID = tes3ui.registerID("crelBeginningRightBlock")
local locationBlockID = tes3ui.registerID("crelLocationListBlock")

this.beginningList = {}
this.sortedBeginningList = {}

this.locationList = {}
this.sortedLocationList = {}

function this.registerBeginnings(beginnings)
	for  _, beginning in pairs(beginnings) do
		table.insert(this.beginningList, beginning)
	end
end

--local loc = beginning.locations.loc1

function this.okayBeginning(beginning, loc, delay, calledFunction)
mwse.log("[CREL TEST] okay called")
	--[[if (beginning.disableItems ~= nil) and (beginning.disableItems == false) then
		common.addStartItems(chosenItems)
		common.addWater(1) --bottle count
	end]]
	common.addStartItems(beginning.items)
mwse.log("[CREL TEST] items")
	--[[if (beginning.disableSpells ~= nil) and (beginning.disableSpells == false) then
		common.addStartSpells(chosenSpells)
	end]]
	common.addStartSpells(beginning.spells)
mwse.log("[CREL TEST] spells")
	common.go(loc[1], loc[2], loc[3], loc[4], loc[5])
mwse.log("[CREL TEST] gone")
	--tes3ui.leaveMenuMode(startMenuID)
    --tes3ui.findMenu(startMenuID):destroy()
	timer.start{ duration = delay, type = timer.simulate, callback = calledFunction }
end

local function clickedLocation(location)
	local loc = location.locData
	common.go(loc[1], loc[2], loc[3], loc[4], loc[5])
	tes3.messageBox("location")
	tes3ui.findMenu(startMenuID):destroy()
    tes3ui.leaveMenuMode()
	common.setup()
end

local function clickedBeginning(beginning)
	this.locationList = {} --clear the list?
	local locationBlock = tes3ui.findMenu(startMenuID):findChild(locationBlockID)
	for  _, location in pairs(beginning.locations) do
		tes3.messageBox("--------------------- %s", location.locData[5])
		table.insert(this.locationList, location)
	end
	--this.sortedLocationList = table.sort(table.copy(this.locationList), function(a, b) return a.locData[5]:lower() < b.locData[5]:lower() end)

	---------------------MENU CONTENT: locations
    for _, location in pairs(this.locationList) do	--TODO: swap for sortedlocationlist
        local locButton = locationBlock:createTextSelect{ id = tes3ui.registerID("crelLocBlock"), text = location.name or location.locData[5] }
		--local locButton = locationBlock:createTextSelect{ id = tes3ui.registerID("crelLocBlock"), text = "well fuck" }
        locButton.autoHeight = true
        locButton.layoutWidthFraction = 1.0
        locButton.paddingAllSides = 2
        locButton.borderAllSides = 2
		locButton.borderRight = 0
        locButton:register("mouseClick", function() clickedLocation(location) end )
    end
	--tes3ui.findMenu(rightBlockID):updateLayout()
end

--function this.createBeginningMenu(delay, calledFunction)
function this.createBeginningMenu()
	--sortBeginningList()
	this.sortedBeginningList = menus.createSortedList("title", this.beginningList, this.sortedBeginningList)
	tes3.messageBox("well I fucked up the sorting function, apparently")
--this.okayBeginning(beginning, loc, 5, doStuff)
	local startMenu = tes3ui.createMenu{ id = startMenuID, fixedFrame = true }
	do
		startMenu.minWidth = 400
		startMenu.autoHeight = true
	end

	local outerBlock = startMenu:createBlock()
	do
		outerBlock.flowDirection = "top_to_bottom"
		outerBlock.autoHeight = true
		outerBlock.autoWidth = true
		outerBlock.alignY = 0
		outerBlock.alignX = 0.5
		outerBlock.paddingAllSides = 6
	end

	local innerBlock = outerBlock:createThinBorder() --swap to block later
	do
		innerBlock.flowDirection = "left_to_right"
		innerBlock.autoHeight = true
		innerBlock.autoWidth = true
		innerBlock.paddingAllSides = 0
	end

	local startListBlock = innerBlock:createVerticalScrollPane{ id = tes3ui.registerID("crelBeginningListBlock") }
	do
		startListBlock.flowDirection = "top-to-bottom"
		startListBlock.layoutHeightFraction = 1.0
		startListBlock.autoWidth = true
		startListBlock.minWidth = 200
		startListBlock.paddingAllSides = 3
	end

	    ---------------------MENU CONTENT: classes
    for _, beginning in pairs(this.sortedBeginningList) do
        local beginningButton = startListBlock:createTextSelect{ id = tes3ui.registerID("crelBeginningBlock"), text = beginning.title }
        beginningButton.autoHeight = true
        beginningButton.layoutWidthFraction = 1.0
        beginningButton.paddingAllSides = 2
        beginningButton.borderAllSides = 2
		beginningButton.borderRight = 0
        beginningButton:register("mouseClick", function() clickedBeginning(beginning) end )
    end

	local rightBlock = innerBlock:createThinBorder{id = rightBlockID}
	do
		rightBlock.flowDirection = "top_to_bottom"
		rightBlock.autoHeight = true
		rightBlock.autoWidth = true
		--rightBlock.maxWidth = 350
		rightBlock.paddingAllSides = 3
	end

	local descriptionBlock = rightBlock:createThinBorder()
	do
		descriptionBlock.autoHeight = true
		descriptionBlock.minHeight = 160
		descriptionBlock.maxHeight = 360
		descriptionBlock.autoWidth = true
		descriptionBlock.minWidth = 400
		descriptionBlock.paddingAllSides = 10
	end

	local locationBlock = rightBlock:createVerticalScrollPane{ id = locationBlockID }
	do
		locationBlock.autoHeight = true
		locationBlock.minHeight = 160
		locationBlock.maxHeight = 200
		locationBlock.autoWidth = true
		locationBlock.minWidth = 400
		locationBlock.paddingAllSides = 3
	end

	local buttonBlock = outerBlock:createThinBorder() --swap to block later
	do
		buttonBlock.flowDirection = "left_to_right"
		buttonBlock.widthProportional = 1.0
		--buttonBlock.autoHeight = true --later fix
		buttonBlock.height = 30
		buttonBlock.childAlignX = 1.0
	end

	tes3ui.enterMenuMode(startMenuID)
	tes3.messageBox("it just works")
end

return this