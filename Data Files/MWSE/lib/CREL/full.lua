--[[
    Allows the creation of messageboxes using buttons that each have their own callback.
    {
        message = "Message",
        buttons = [
            { text = "Button text", callback = function() }
        ]
    }
]]
--local this = {}
--function this.messageBox(params)
local function messageBox(params)
    --[[
        Button = { text = string, callback = function }
    ]]--
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

local chargen

------------------
--CLASSES
------------------
local classList = {}

--from qqbb!!!!!!!!!


local pcClass

local function setClass()
	tes3.mobileplayer.class = pcClass
end

local function PairsByKeys (t, f)
-- this is 9 times faster than table.sort
	local a = {};
	for n in pairs(t) do
		table.insert(a, n);
	end
	table.sort(a, f);
	local i = 0;      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1;
		if a[i] == nil then
			return nil;
		else 
			return a[i], t[a[i]];
		end
	end
	return iter;
end

local function getClasses()
    --local temp = {}
    --local classes = tes3.dataHandler.nonDynamicData.classes
	--local classTable = {}

	--local t = {}
    local NPCclass
    for npc in tes3.iterateObjects(tes3.objectType.npc) do
    NPCclass = npc.class
        if (classList[NPCclass.id] == nil) then
            if (NPCclass.playable == true) then
                classList[NPCclass.id] = NPCclass
                mwse.log("------------- %s", NPCclass.id)
            end
        end
    end
	--[[for _, class in pairs(tes3.dataHandler.nonDynamicData.classes) do
		-- GetNumRanks(faction);
		mwse.log('%s    %s', class.id, class.name);
		--t[faction.name] = faction;
    end]]
	--for name, faction in PairsByKeys(t) do
		--table.insert(classList, faction);
    --end

	--[[local t = {}
	for k, class in pairs(tes3.dataHandler.nonDynamicData.classes) do
		mwse.log('%s    %s', class.id, class.name);
		t[class.name] = class;
    end
	for name, class in PairsByKeys(t) do
		table.insert(classList, class);
    end]]--
	tes3.messageBox("classlist done")
end

--nuked # here!
    --for _, tes3iteratorNode in pairs(classes) do
	--table.insert(classTable, tes3iteratorNode)
		--if (classes[i].playable == true) then
       		--temp[classes[i].id:lower()] = true
		--end
    --end
    --[[for name in pairs(temp) do
        classList[#classList+1] = name
    end
    table.sort(classList)
    return classList]]




local classMenuID = tes3ui.registerID("crelClassMenu")
local classDescriptionID = tes3ui.registerID("crelClassDescriptionText")
local classDescriptionHeaderID = tes3ui.registerID("crelClassHeaderText")

local data

local classNameID = tes3ui.registerID("crelClassNameUI")

-----------------------------------------------------------------
local okayButton


local function clickedPerk(class)
tes3.messageBox("yay %s", class)

    pcClass = class
    
    local header = tes3ui.findMenu(classMenuID):findChild(classDescriptionHeaderID)
    header.text = class.name

    local description = tes3ui.findMenu(classMenuID):findChild(classDescriptionID)
    description.text = class.description
    description:updateLayout()
    end
    --[[if backgroundsList[data.currentBackground].checkDisabled and backgroundsList[data.currentBackground].checkDisabled() then 
        header.color = tes3ui.getPalette("disabled_color")
        okayButton.widget.state = 2
        okayButton.disabled = true
    else
        header.color = tes3ui.getPalette("header_color")
        okayButton.widget.state = 1
        okayButton.disabled = false
    end

end]]


--[[
local function clickedOkay()
    if data.currentBackground then 
        --if backgroundsList[data.currentBackground].checkDisabled and backgroundsList[data.currentBackground].checkDisabled() then return end
        local background = backgroundsList[data.currentBackground]
        if background.doOnce then
            background.doOnce(data)
        end

        if background.callback then
            background.callback(data)
        end

        
    end
    tes3ui.findMenu(classMenuID):destroy()
    tes3ui.leaveMenuMode()
end]]

--this creates the menu

local function createClassMenu()
getClasses()
    --if not modReady() then return end
    local classMenu = tes3ui.createMenu{id = classMenuID, fixedFrame = true}
    local outerBlock = classMenu:createBlock()
    outerBlock.flowDirection = "top_to_bottom"
    outerBlock.autoHeight = true
    outerBlock.autoWidth = true

    --HEADING
    local title = outerBlock:createLabel{ id = tes3ui.registerID("crelClassHeading"), text = "Select class:" }
    title.absolutePosAlignX = 0.5
    title.borderTop = 4
    title.borderBottom = 4

    local innerBlock = outerBlock:createBlock()
    innerBlock.height = 350
    innerBlock.autoWidth = true
    innerBlock.flowDirection = "left_to_right"

    --PERKS
    local classListBlock = innerBlock:createVerticalScrollPane{ id = tes3ui.registerID("crelClassListBlock") }
    classListBlock.layoutHeightFraction = 1.0
    classListBlock.minWidth = 200
    classListBlock.autoWidth = true
    classListBlock.paddingAllSides = 4
    classListBlock.borderRight = 6

    --local sort_func = function(a, b)
        --return string.lower(a.name) < string.lower(b.name)
    --end
    
    --[[local sortedList = {}
    for _, background in pairs(backgroundsList) do
        table.insert(sortedList, background)
    end
    table.sort(sortedList, sort_func)]]

    --Default "No background" button
    
    --[[local noBGButton = perkListBlock:createTextSelect{ text = "-Select Background-" }
    do
        noBGButton.color = tes3ui.getPalette("disabled_color")
        noBGButton.widget.idle = tes3ui.getPalette("disabled_color")
        noBGButton.autoHeight = true
        noBGButton.layoutWidthFraction = 1.0
        noBGButton.paddingAllSides = 2
        noBGButton.borderAllSides = 2

        noBGButton:register("mouseClick", function()
            data.currentBackground = nil
            local header = tes3ui.findMenu(classMenuID):findChild(classDescriptionHeaderID)
            header.text = "No Background Selected"
        
            local description = tes3ui.findMenu(classMenuID):findChild(classDescriptionID)
            description.text = "Select a Background from the list."
            description:updateLayout()
        end)
    end]]

    --Rest of the buttons
    for _, class in pairs(classList) do
        local classButton = classListBlock:createTextSelect{ id = tes3ui.registerID("crelClassBlock"), text = class.name }
        classButton.autoHeight = true
        classButton.layoutWidthFraction = 1.0
        classButton.paddingAllSides = 2
        classButton.borderAllSides = 2
        classButton:register("mouseClick", function() clickedPerk(class) end )
        
        

    end
    --DESCRIPTION
    do
        local descriptionBlock = innerBlock:createThinBorder()
        descriptionBlock.layoutHeightFraction = 0.4
        descriptionBlock.width = 400
        descriptionBlock.borderRight = 10
        descriptionBlock.flowDirection = "top_to_bottom"
        descriptionBlock.paddingAllSides = 10

        local descriptionHeader = descriptionBlock:createLabel{ id = classDescriptionHeaderID, text = ""}
        descriptionHeader.color = tes3ui.getPalette("header_color")

        local descriptionText = descriptionBlock:createLabel{id = classDescriptionID, text = ""}
        descriptionText.wrapText = true
    end

    local classMajorSkillBlock = innerBlock:createThinBorder()
    classMajorSkillBlock.autoHeight = true
    classMajorSkillBlock.minWidth = 150
    classMajorSkillBlock.autoWidth = true
    classMajorSkillBlock.paddingAllSides = 4
    classMajorSkillBlock.borderRight = 6

    local buttonBlock = outerBlock:createBlock()
    buttonBlock.flowDirection = "left_to_right"
    buttonBlock.widthProportional = 1.0
    buttonBlock.autoHeight = true
    buttonBlock.childAlignX = 1.0


    --Randomise
    --[[local randomButton = buttonBlock:createButton{ text = "Random"}
    randomButton.alignX = 1.0
    randomButton:register("mouseClick", function()
        local list = perkListBlock:getContentElement().children
        list[ math.random(#list) ]:triggerEvent("mouseClick")
    end)]]


    --OKAY
    okayButton = buttonBlock:createButton{ id = tes3ui.registerID("perkOkayButton"), text = tes3.findGMST(tes3.gmst.sOK).value }
    okayButton.alignX = 1.0
    okayButton:register("mouseClick", setClass)

    classMenu:updateLayout()

    tes3ui.enterMenuMode(classMenuID)
    --noBGButton:triggerEvent("mouseClick")
end





------------------
--CLASSES END
------------------

------------------
--MENU
------------------
--[[

local perksMenuID = tes3ui.registerID("perksMenu")
local descriptionID = tes3ui.registerID("perkDescriptionText")
local descriptionHeaderID = tes3ui.registerID("perkDescriptionHeaderText")

local data

local bgUID = tes3ui.registerID("BackgroundNameUI")

local function updateBGStat()
    local menu = tes3ui.findMenu(tes3ui.registerID("MenuStat"))
    if menu then 
        local background = menu:findChild(bgUID)
       
        if data and data.currentBackground then
            background.text =  backgroundsList[data.currentBackground].name
        else
            background.text = "None"
        end
        menu:updateLayout()
    end
end

local function getDescription(background)
    if type(background.description) == "function" then
        return background.description()
    else
        return background.description
    end
end

-----------------------------------------------------------------
local okayButton

local function clickedPerk(background)
    data.currentBackground = background.id
    
    local header = tes3ui.findMenu(perksMenuID):findChild(descriptionHeaderID)
    header.text = background.name

    local description = tes3ui.findMenu(perksMenuID):findChild(descriptionID)
    description.text = getDescription(background)
    description:updateLayout()
    
    if backgroundsList[data.currentBackground].checkDisabled and backgroundsList[data.currentBackground].checkDisabled() then 
        header.color = tes3ui.getPalette("disabled_color")
        okayButton.widget.state = 2
        okayButton.disabled = true
    else
        header.color = tes3ui.getPalette("header_color")
        okayButton.widget.state = 1
        okayButton.disabled = false
    end

end

local function clickedOkay()
    if data.currentBackground then 
        --if backgroundsList[data.currentBackground].checkDisabled and backgroundsList[data.currentBackground].checkDisabled() then return end
        local background = backgroundsList[data.currentBackground]
        if background.doOnce then
            background.doOnce(data)
        end

        if background.callback then
            background.callback(data)
        end

        
    end
    tes3ui.findMenu(perksMenuID):destroy()
    tes3ui.leaveMenuMode()
    updateBGStat()
end


local function createPerkMenu()
    if not modReady() then return end
    local perksMenu = tes3ui.createMenu{id = perksMenuID, fixedFrame = true}
    local outerBlock = perksMenu:createBlock()
    outerBlock.flowDirection = "top_to_bottom"
    outerBlock.autoHeight = true
    outerBlock.autoWidth = true

    --HEADING
    local title = outerBlock:createLabel{ id = tes3ui.registerID("perksheading"), text = "Select your background:" }
    title.absolutePosAlignX = 0.5
    title.borderTop = 4
    title.borderBottom = 4

    local innerBlock = outerBlock:createBlock()
    innerBlock.height = 350
    innerBlock.autoWidth = true
    innerBlock.flowDirection = "left_to_right"

    --PERKS
    local perkListBlock = innerBlock:createVerticalScrollPane{ id = tes3ui.registerID("perkListBlock") }
    perkListBlock.layoutHeightFraction = 1.0
    perkListBlock.minWidth = 300
    perkListBlock.autoWidth = true
    perkListBlock.paddingAllSides = 4
    perkListBlock.borderRight = 6

    local sort_func = function(a, b)
        return string.lower(a.name) < string.lower(b.name)
    end
    
    local sortedList = {}
    for _, background in pairs(backgroundsList) do
        table.insert(sortedList, background)
    end
    table.sort(sortedList, sort_func)

    --Default "No background" button
    
    local noBGButton = perkListBlock:createTextSelect{ text = "-Select Background-" }
    do
        noBGButton.color = tes3ui.getPalette("disabled_color")
        noBGButton.widget.idle = tes3ui.getPalette("disabled_color")
        noBGButton.autoHeight = true
        noBGButton.layoutWidthFraction = 1.0
        noBGButton.paddingAllSides = 2
        noBGButton.borderAllSides = 2

        noBGButton:register("mouseClick", function()
            data.currentBackground = nil
            local header = tes3ui.findMenu(perksMenuID):findChild(descriptionHeaderID)
            header.text = "No Background Selected"
        
            local description = tes3ui.findMenu(perksMenuID):findChild(descriptionID)
            description.text = "Select a Background from the list."
            description:updateLayout()
        end)
    end

    --Rest of the buttons
    for _, background in pairs(sortedList) do
        local perkButton = perkListBlock:createTextSelect{ id = tes3ui.registerID("perkBlock"), text = background.name }
        perkButton.autoHeight = true
        perkButton.layoutWidthFraction = 1.0
        perkButton.paddingAllSides = 2
        perkButton.borderAllSides = 2
        if background.checkDisabled and background.checkDisabled() then
            perkButton.color = tes3ui.getPalette("disabled_color")
            perkButton.widget.idle = tes3ui.getPalette("disabled_color")
        end
        perkButton:register("mouseClick", function() clickedPerk(background) end )
        
        

    end
    --DESCRIPTION
    do
        local descriptionBlock = innerBlock:createThinBorder()
        descriptionBlock.layoutHeightFraction = 1.0
        descriptionBlock.width = 300
        descriptionBlock.borderRight = 10
        descriptionBlock.flowDirection = "top_to_bottom"
        descriptionBlock.paddingAllSides = 10

        local descriptionHeader = descriptionBlock:createLabel{ id = descriptionHeaderID, text = ""}
        descriptionHeader.color = tes3ui.getPalette("header_color")

        local descriptionText = descriptionBlock:createLabel{id = descriptionID, text = ""}
        descriptionText.wrapText = true
    end

    local buttonBlock = outerBlock:createBlock()
    buttonBlock.flowDirection = "left_to_right"
    buttonBlock.widthProportional = 1.0
    buttonBlock.autoHeight = true
    buttonBlock.childAlignX = 1.0


    --Randomise
    local randomButton = buttonBlock:createButton{ text = "Random"}
    randomButton.alignX = 1.0
    randomButton:register("mouseClick", function()
        local list = perkListBlock:getContentElement().children
        list[ math.random(#list) ]:triggerEvent("mouseClick")
    end)


    --OKAY
    okayButton = buttonBlock:createButton{ id = tes3ui.registerID("perkOkayButton"), text = tes3.findGMST(tes3.gmst.sOK).value }
    okayButton.alignX = 1.0
    okayButton:register("mouseClick", clickedOkay)

    perksMenu:updateLayout()

    tes3ui.enterMenuMode(perksMenuID)
    noBGButton:triggerEvent("mouseClick")
end

]]
------------------
--MENU END
------------------

local function toggle()
	--tes3.runLegacyScript{command = "ToggleScripts"}
	--tes3.runLegacyScript{command = "ToggleWorld"}
	mwse.log("aa")
end

local function enableAll()
	tes3.runLegacyScript{command = "EnablePlayerViewSwitch"}
	tes3.runLegacyScript{command = "EnablePlayerControls"}
	tes3.runLegacyScript{command = "EnablePlayerLooking"}
	tes3.runLegacyScript{command = "EnablePlayerFighting"}
	tes3.runLegacyScript{command = "EnablePlayerJumping"}
	tes3.runLegacyScript{command = "EnablePlayerMagic"}
	tes3.runLegacyScript{command = "EnableInventoryMenu"}
	tes3.runLegacyScript{command = "EnableMagicMenu"}
	tes3.runLegacyScript{command = "EnableMapMenu"}
	tes3.runLegacyScript{command = "EnableStatsMenu"}
	tes3.runLegacyScript{command = "FadeIn 0.5"}
end

local function testMove()
	tes3.runLegacyScript{command = "coc Balmora"}
end

--local function stopScripts()

--end

local function setTestStats()
	--local skillNumber = 0
	local skillTable = tes3.mobilePlayer.skills
	for skillNumber in ipairs(skillTable) do
		tes3.setStatistic({
					reference = tes3.mobilePlayer,
					skill = skillNumber - 1,
					current = 100
				})
				mwse.log("DEBUG modified %.0f", skillNumber)
			end
		local attrTable = tes3.mobilePlayer.attributes
	for attrNumber in ipairs(attrTable) do
		tes3.setStatistic({
					reference = tes3.mobilePlayer,
					attribute = attrNumber - 1,
					current = 100
				})
				mwse.log("DEBUG modified attr %.0f", attrNumber)
			end
				tes3.setStatistic({
					reference = tes3.mobilePlayer,
					name = "health",
					value = 5000
				})
				tes3.setStatistic({
					reference = tes3.mobilePlayer,
					name = "magicka",
					value = 5000
				})
				tes3.setStatistic({
					reference = tes3.mobilePlayer,
					name = "fatigue",
					value = 5000
				})
end

local function addTestItems()
	mwscript.addItem{
                reference = tes3.player, 
                item = "torch",
                count = 5
            }
	mwscript.addItem{
                reference = tes3.player, 
                item = "gold_001",
                count = 1000
            }
	mwscript.addItem{
                reference = tes3.player, 
                item = "misc_soulgem_grand",
                count = 10
            }
				mwscript.addItem{
                reference = tes3.player, 
                item = "silver arrow",
                count = 100
            }
				mwscript.addItem{
                reference = tes3.player, 
                item = "silver longsword",
                count = 1
            }
				mwscript.addItem{
                reference = tes3.player, 
                item = "bonemold long bow",
                count = 1
            }
end
local testSpells = {
		["almsivi intervention"] = true,
		["recall"] = true;
		["detect creature"] = true,
		["dispel"] = true,
		["divine intervention"] = true,
		["mark"] = true,
		["soul trap"] = true,
		["telekinesis"] = true,
		["strong levitate"] = true,
		["strong open"] = true,
		["slowfall"] = true,
		["swimmer's blessing"] = true,
		["vivec's kiss"] = true,
		["water walking"] = true,
		["charming touch"] = true,
		["concealment"] = true,
		["chameleon"] = true,
		["night eye"] = true,
		["summon scamp"] = true,
		["summon golden saint"] = true,
		["cure common disease"] = true,
		["cure blight disease"] = true,
		["cure poison"] = true,
		["rapid regenerate"] = true,
	}
local function addTestSpells()
	for testSpell in pairs(testSpells) do
		mwscript.addSpell{
                reference = tes3.player, 
                spell = testSpell
		}
	end
end

local function chooseModeDefault()
event.trigger("[CREL] default mode chosen")
--[[DisablePlayerControls
DisablePlayerJumping
DisablePlayerViewSwitch
DisableVanityMode
DisablePlayerFighting
DisablePlayerMagic
Player->PositionCell 61,-135, 24, 340, "Imperial Prison Ship"
ChangeWeather "Bitter Coast Region" 1 ;sets beginning weather to cloudy, looks nicer
]]
	toggle()
	tes3.runLegacyScript{command = "FadeIn 0.5"}
	mwse.log("[CREL] beginning set to default")
end

local pcName

local function setName()
	tes3.mobileplayer.name = pcName
end

local function customMenuName()
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

local function customMenuClass()
	tes3.runLegacyScript{command = "EnableClassMenu"}
	timer.start{ duration = 0.05, type = timer.simulate, callback = customMenuName }
	tes3.messageBox("DEBUG: this one is in for a complete replacement")
end

local function customMenuBirthsign()
	tes3.runLegacyScript{command = "EnableBirthMenu"}
	--timer.start{ duration = 0.05, type = timer.simulate, callback = customMenuClass }
	timer.start{ duration = 0.05, type = timer.simulate, callback = createClassMenu }
end

local function chooseModeCustom()
event.trigger("[CREL] custom mode chosen")
	mwse.log("[CREL] beginning set to custom")
	--tes3.runLegacyScript{command = "EnableRaceMenu"}
	--timer.start{ duration = 0.05, type = timer.simulate, callback = customMenuBirthsign }
	--createClassMenu()
	customMenuBirthsign()
end

local function chooseModeTest()
	event.trigger("[CREL] test mode chosen")
	setTestStats()
	addTestItems()
	addTestSpells()
	toggle()
	enableAll()
	testMove()
	mwse.log("[CREL] beginning set to test")
end

local function chooseChargenMode()
	messageBox({
            message = "Chargen Mode",
            buttons = {
    			{ text = "Custom", callback =  chooseModeCustom},
	    		{ text = "Default", callback = chooseModeDefault},
    			{ text = "Test", callback =  chooseModeTest}
			}
        })
end

local function onLoaded(e)
	--tes3.runLegacyScript{command = "FadeOut 0.3"}
	event.unregister("loaded", onLoaded)
	timer.start{ duration = 1, type = timer.simulate, callback = chooseChargenMode }
end



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

local function onLoad(e)
	if (e.newGame == true) then
	event.trigger("[CREL] new game")
		--[[local MenuID01 = tes3ui.registerID("Menu01")
		local Menu01 = tes3ui.createMenu{id = MenuID01, fixedFrame = true}
		tes3ui.enterMenuMode(MenuID01)]]
		--toggle()
		event.register("loaded", onLoaded)
	end
end

local function onInitialized()
	event.register("load", onLoad)
	mwse.overrideScript("CharGen", nukeDefaultChargen)
	mwse.overrideScript("CharGenNameNPC", nukeDefaultJiubIntro)
	mwse.overrideScript("CharGenCustomsDoor", nukeDefaultTrapdoor)
	tes3.messageBox("[CREL] initialized")
end

event.register("initialized", onInitialized)