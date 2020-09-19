	--[[
		Functions for the faction menu.
	]]

local this = {}

local okayButton

local optionsMenuID = tes3ui.registerID("crelOptionsMenu")

--note that all but the basic factions need their mod requirements added!
--that is, when the requirement functions are done... #2090

this.factionList = {    --TEST
                { label = "NONE", value = nil},
                { label = "Great House Redoran", value = "Redoran"},
                { label = "Great House Hlaalu", value = "Hlaalu"},
				{ label = "Great House Indoril", value = "T_Mw_HouseIndoril"},
				{ label = "Great House Dres", value = "T_Mw_HouseDres"},
				{ label = "Great House Telvani", value = "Telvanni"},
				{ label = "Great House Dagoth", value = "Sixth House"},
				{ label = "Tribunal Temple", value = "Temple"},
				{ label = "Morag Tong", value = "Morag Tong"},
				{ label = "Camonna Tong", value = "Camonna Tong"},
				{ label = "Imperial Legion", value = "Imperial Legion"},
				{ label = "Fighters Guild", value = "Fighters Guild"},
				{ label = "Mages Guild", value = "Mages Guild"},
				{ label = "Thieves Guild", value = "Thieves Guild"},
				{ label = "Ashlanders", value = "Ashlanders"},
				{ label = "Census and Excise Office", value = "Census and Excise"},
				{ label = "Dark Brotherhood", value = "Dark Brotherhood"},
				{ label = "East Empire Company", value = "East Empire Company"},
				{ label = "Imperial Cult", value = "Imperial Cult"},
				{ label = "Imperial Knights", value = "Imperial Knights"},
				{ label = "Skaal", value = "Skaal"},
				{ label = "Twin Lamps", value = "Twin Lamps"},
				{ label = "East Navy", value = "T_Mw_ImperialNavy"},
				{ label = "Imperial Archaeological Society", value = "T_Glb_ArchaeologicalSociety"},
				{ label = "Niben Hierophants", value = "T_Cyr_NibenHierophants"},
				{ label = "Imperial Curia", value = "T_Cyr_ImperialCuria"},
            }

local chosenFaction

function this.setFaction()
	chosenFaction = tes3.getFaction(value)
	chosenFaction.playerJoined = true
    tes3ui.leaveMenuMode()
	tes3.messageBox("faction picked")
end

local function clickedFaction(faction)
 --dostuff
end

--------------------------------------------------------------------------------------------

--this creates the menu

function this.createFactionMenu()
	getClasses()
    --if not modReady() then return end

	-------MENU BLOCK: outer

    local factionMenu = tes3ui.createMenu{id = optionsMenuID, fixedFrame = true}
    local outerBlock = factionMenu:createBlock()
		outerBlock.flowDirection = "top_to_bottom"
		outerBlock.autoHeight = true
		outerBlock.autoWidth = true

    local title = outerBlock:createLabel{ id = tes3ui.registerID("crelFactionHeading"), text = "Additional options" }
		title.absolutePosAlignX = 0.5
		title.borderTop = 4
		title.borderBottom = 4

	--------------MENU BLOCK: inner

    local innerBlock = outerBlock:createBlock()
		innerBlock.autoWidth = true
		innerBlock.autoHeight = true
		innerBlock.minWidth = 500
		innerBlock.minHeight = 400
    	innerBlock.flowDirection = "left_to_right"

	---------------------MENU BLOCK: faction list

    local factionListBlock = innerBlock:createVerticalScrollPane{ id = tes3ui.registerID("crelFactionListBlock") }
		factionListBlock.layoutHeightFraction = 1.0
		factionListBlock.minWidth = 200
		factionListBlock.autoWidth = true
		factionListBlock.paddingAllSides = 4
		factionListBlock.borderRight = 6

    ---------------------MENU CONTENT: factions
    for _, faction in pairs(this.factionList) do
        local factionButton = factionListBlock:createTextSelect{ id = tes3ui.registerID("crelFactionBlock"), text = faction.label }
        factionButton.autoHeight = true
        factionButton.layoutWidthFraction = 1.0
        factionButton.paddingAllSides = 2
        factionButton.borderAllSides = 2
		factionButton.borderRight = 0
        factionButton:register("mouseClick", function() clickedFaction(faction) end )
    end

--option is one clickable button
--optionTable is the table with options that should be buttons
--uiBlock is the block to create the list in
--uiID is the ID of the created list
--textVar is what is used to get the button text from

	---------------------MENU BLOCK: class info

	local rightBlock = innerBlock:createBlock()

    do
		rightBlock.autoWidth = true
		rightBlock.autoHeight = true
        rightBlock.flowDirection = "top_to_bottom"
        rightBlock.paddingAllSides = 0
		rightBlock.paddingRight = 2
    end

    ----------------------------MENU BLOCK: class description

	local descriptionBlock

    do
        descriptionBlock = rightBlock:createThinBorder()
        descriptionBlock.heightProportional = 1.0
        descriptionBlock.width = 400
        descriptionBlock.borderRight = 4
        descriptionBlock.flowDirection = "top_to_bottom"
        descriptionBlock.paddingAllSides = 10

        local descriptionHeader = descriptionBlock:createLabel{ id = classDescriptionHeaderID, text = ""}
        descriptionHeader.color = tes3ui.getPalette("header_color")

        local descriptionText = descriptionBlock:createLabel{id = classDescriptionID, text = ""}
        descriptionText.wrapText = true
    end

	----------------------------MENU BLOCK: favored skills

	local factionInfoBlock = rightBlock:createThinBorder()

    do
		factionInfoBlock.width = 400
		factionInfoBlock.heightProportional = 1.0
        factionInfoBlock.flowDirection = "top_to_bottom"
        factionInfoBlock.paddingAllSides = 0
		factionInfoBlock.paddingTop = 6
    end

	-----------------------------------MENU BLOCK: class specialization

    local classSpecBlock = classInfoBlock:createThinBorder()
	do
		classSpecBlock.autoHeight = true
		classSpecBlock.width = 400
		classSpecBlock.paddingAllSides = 10
		classSpecBlock.borderRight = 6

		local specHeader = classSpecBlock:createLabel{ id = classSpecHeaderID, text = this.specHeaderText}
        specHeader.color = tes3ui.getPalette("header_color")

        classSpecBlock:createLabel{id = classSpecTextID, text = ""}
	end

	-------------------MENU BLOCK: buttons on the bottom

    local buttonBlock = outerBlock:createBlock()
	do
		buttonBlock.flowDirection = "left_to_right"
		buttonBlock.widthProportional = 1.0
		buttonBlock.autoHeight = true
		buttonBlock.childAlignX = 1.0
	end

    --Randomise
    --[[local randomButton = buttonBlock:createButton{ text = "Random"}
    randomButton.alignX = 1.0
    randomButton:register("mouseClick", function()
        local list = perkListBlock:getContentElement().children
        list[ math.random(#list) ]:triggerEvent("mouseClick")
    end)]]


	---------------------MENU BLOCK: okay button

    okayButton = buttonBlock:createButton{ id = tes3ui.registerID("perkOkayButton"), text = tes3.findGMST(tes3.gmst.sOK).value }
    	okayButton.alignX = 1.0
    	okayButton:register("mouseClick", this.setClass)

    factionMenu:updateLayout()

    tes3ui.enterMenuMode(optionsMenuID)
    --noBGButton:triggerEvent("mouseClick")
end



function this.createOptionsMenu()
	local optionsMenu = tes3ui.createMenu{id = optionsMenuID, fixedFrame = true}

	local outerOptionsBlock = optionsMenu:createBlock()
	do
		outerOptionsBlock.flowDirection = "top_to_bottom"
		--outerOptionsBlock.autoHeight = true
		outerOptionsBlock.height = 600
		--outerOptionsBlock.autoWidth = true
		outerOptionsBlock.width = 400

    	local title = outerOptionsBlock:createLabel{ id = tes3ui.registerID("crelOptionsHeading"), text = "Optional settings:" }
		title.absolutePosAlignX = 0.5
		title.borderTop = 4
		title.borderBottom = 4
	end



	tes3ui.enterMenuMode(optionsMenuID)

end

return this