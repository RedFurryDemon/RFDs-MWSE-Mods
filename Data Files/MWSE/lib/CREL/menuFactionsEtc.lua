	--[[
		Functions for creating menus, shared among chargen files.
	]]

local this = {}

local classList = {}
this.sortedClassList = {}

local okayButton



local data


local classNameID = tes3ui.registerID("crelClassNameUI")

--------------------------------------------------------------------------------------------
--CLASS-RELATED MISC FUNCTIONS
--------------------------------------------------------------------------------------------

--this function nukes class menu and sets PC class

--local pcClass

function this.setClass()
	--local classMenuID = tes3ui.findMenu("crelClassMenu")
    --tes3ui.findMenu(classMenuID):destroy()
    tes3ui.leaveMenuMode()
	tes3.messageBox("class picked")
	tes3.runLegacyScript{command = "coc Vivec"}
	--tes3.mobilePlayer.class = pcClass
end
--------------------------------------------------------------------------------------------

--this function creates a list of playable classes
--admittedly, currently it's a bit fucky because tes3.dataHandler.nonDynamicData.classes doesn't work yet

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
	table.sort(classList)
	tes3.messageBox("classlist done")
end
--------------------------------------------------------------------------------------------

--[[
	this function calculates starting skill value (initial + racial bonus)
	skillNumber is the ID of skill to check
]]

this.skillBaseValue = 5

function this.calcSkillBase(skillNumber)
	local base = this.skillBaseValue

	--local skillName = tes3.getSkillName(skillNumber)
	local skillBonuses = tes3.player.baseObject.race.skillBonuses

	for _, raceBonus in ipairs(skillBonuses) do
		if (raceBonus.skill == skillNumber) then
			base = base + raceBonus.bonus
			--mwse.log("------------------------ %s %.0f", skillName, base)
		end
		--mwse.log("------------ %s %.0f", skillName, base)
	end

	--TODO: add a check for birthsigns
	return base
end
--------------------------------------------------------------------------------------------

--[[
	this function calculates bonus to a skill
	class is tes3class, skillNumber is the skill ID (see Reference table in MWSE docs)
	skillType: 0 - major, 1 - minor, 2 - misc (also in Reference)
]]

this.majorSkillBonus = 25
this.minorSkillBonus = 10
this.miscSkillBonus = 0
this.specBonus = 5

function this.calcSkillBonus(class, skillNumber, skillType)
	local bonus = 0

	local skill = tes3.getSkill(skillNumber)

	if (class.specialization == skill.specialization) then
		bonus = bonus + this.specBonus
	end

	if (skillType == 0) then
		bonus = bonus + this.majorSkillBonus
	elseif (skillType == 1) then
		bonus = bonus + this.minorSkillBonus
	elseif (skillType == 2) then
		bonus = bonus + this.miscSkillBonus
	end
	return bonus
end
--------------------------------------------------------------------------------------------

this.specHeader = ""

--this function displays class data (description, skills, etc) after clicking on a class

local classMenuID = tes3ui.registerID("crelClassMenu")
local classDescriptionID = tes3ui.registerID("crelClassDescriptionText")
local classDescriptionHeaderID = tes3ui.registerID("crelClassDescrHeaderText")
local classAttrHeaderID = tes3ui.registerID("crelClassAttrHeaderText")
local classSpecHeaderID = tes3ui.registerID("crelClassSpecHeaderText")
local classMajorHeaderID = tes3ui.registerID("crelClassMajorHeaderText")
local classMinorHeaderID = tes3ui.registerID("crelClassMinorHeaderText")
local majorSkillTextID = tes3ui.registerID("crelClassMajorSkillText")
local minorSkillTextID = tes3ui.registerID("crelClassMinorSkillText")
local rightBlockID = tes3ui.registerID("crelRightBlock")

local classAttrTextID = tes3ui.registerID("crelClassAttrText")
local classSpecTextID = tes3ui.registerID("crelClassSpecText")

local function clickedClass(class)

	

    --pcClass = class
	--tes3.player.baseObject.class = class

	--check which specialization label should be displayed

	local spec = class.specialization
	if (spec == 0) then
		this.specText = "Combat"
	elseif (spec == 1) then
		this.specText = "Magic"
	elseif (spec == 2) then
		this.specText = "Stealth"
	end

    local descrHeader = tes3ui.findMenu(classMenuID):findChild(classDescriptionHeaderID)
    descrHeader.text = class.name

	local specHeader = tes3ui.findMenu(classMenuID):findChild(classSpecHeaderID)
    specHeader.text = "Specialization"
	local attrHeader = tes3ui.findMenu(classMenuID):findChild(classAttrHeaderID)
    attrHeader.text = "Favored attributes"
    local description = tes3ui.findMenu(classMenuID):findChild(classDescriptionID)
    description.text = class.description
	local specializationText = tes3ui.findMenu(classMenuID):findChild(classSpecTextID)
	specializationText.text = this.specText

	local rightBlock = tes3ui.findMenu(classMenuID):findChild(rightBlockID)

	local classAttr1 = tes3.getAttributeName(class.attributes[1])
	local classAttr2 = tes3.getAttributeName(class.attributes[2])
	local attrText = tes3ui.findMenu(classMenuID):findChild(classAttrTextID)
	attrText.text = string.format("%s and %s", classAttr1, classAttr2)

	local majorSkillText = tes3ui.findMenu(classMenuID):findChild(majorSkillTextID)
	local minorSkillText = tes3ui.findMenu(classMenuID):findChild(minorSkillTextID)

	local majorSkill1 = tes3.getSkillName(class.majorSkills[1])
	local majorSkill2 = tes3.getSkillName(class.majorSkills[2])
	local majorSkill3 = tes3.getSkillName(class.majorSkills[3])
	local majorSkill4 = tes3.getSkillName(class.majorSkills[4])
	local majorSkill5 = tes3.getSkillName(class.majorSkills[5])

	local minorSkill1 = tes3.getSkillName(class.minorSkills[1])
	local minorSkill2 = tes3.getSkillName(class.minorSkills[2])
	local minorSkill3 = tes3.getSkillName(class.minorSkills[3])
	local minorSkill4 = tes3.getSkillName(class.minorSkills[4])
	local minorSkill5 = tes3.getSkillName(class.minorSkills[5])

	local majorSkill1base = this.calcSkillBase(class.majorSkills[1])
	local majorSkill2base = this.calcSkillBase(class.majorSkills[2])
	local majorSkill3base = this.calcSkillBase(class.majorSkills[3])
	local majorSkill4base = this.calcSkillBase(class.majorSkills[4])
	local majorSkill5base = this.calcSkillBase(class.majorSkills[5])

	local minorSkill1base = this.calcSkillBase(class.minorSkills[1])
	local minorSkill2base = this.calcSkillBase(class.minorSkills[2])
	local minorSkill3base = this.calcSkillBase(class.minorSkills[3])
	local minorSkill4base = this.calcSkillBase(class.minorSkills[4])
	local minorSkill5base = this.calcSkillBase(class.minorSkills[5])

	local majorSkill1bonus = majorSkill1base + this.calcSkillBonus(class, class.majorSkills[1], 0)
	local majorSkill2bonus = majorSkill2base + this.calcSkillBonus(class, class.majorSkills[2], 0)
	local majorSkill3bonus = majorSkill3base + this.calcSkillBonus(class, class.majorSkills[3], 0)
	local majorSkill4bonus = majorSkill4base + this.calcSkillBonus(class, class.majorSkills[4], 0)
	local majorSkill5bonus = majorSkill5base + this.calcSkillBonus(class, class.majorSkills[5], 0)

	local minorSkill1bonus = minorSkill1base + this.calcSkillBonus(class, class.minorSkills[1], 1)
	local minorSkill2bonus = minorSkill2base + this.calcSkillBonus(class, class.minorSkills[2], 1)
	local minorSkill3bonus = minorSkill3base + this.calcSkillBonus(class, class.minorSkills[3], 1)
	local minorSkill4bonus = minorSkill4base + this.calcSkillBonus(class, class.minorSkills[4], 1)
	local minorSkill5bonus = minorSkill5base + this.calcSkillBonus(class, class.minorSkills[5], 1)

	majorSkillText.text = string.format("%s %.0f -> %.0f\n%s %.0f -> %.0f\n%s %.0f -> %.0f\n%s %.0f -> %.0f\n%s %.0f -> %.0f", majorSkill1, majorSkill1base, majorSkill1bonus, majorSkill2, majorSkill2base, majorSkill2bonus, majorSkill3, majorSkill3base, majorSkill3bonus, majorSkill4, majorSkill4base, majorSkill4bonus, majorSkill5, majorSkill5base, majorSkill5bonus)
	minorSkillText.text = string.format("%s (%.0f -> %.0f)\n%s (%.0f -> %.0f)\n%s (%.0f -> %.0f)\n%s %.0f -> %.0f\n%s %.0f -> %.0f", minorSkill1, minorSkill1base, minorSkill1bonus, minorSkill2, minorSkill2base, minorSkill2bonus, minorSkill3, minorSkill3base, minorSkill3bonus, minorSkill4, minorSkill4base, minorSkill4bonus, minorSkill5, minorSkill5base, minorSkill5bonus)
    --rightBlock:updateLayout()
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
--------------------------------------------------------------------------------------------

--this creates the menu

function this.createClassMenu()
	getClasses()
    --if not modReady() then return end

	-------MENU BLOCK: outer

    local classMenu = tes3ui.createMenu{id = classMenuID, fixedFrame = true}
    local outerBlock = classMenu:createBlock()
		outerBlock.flowDirection = "top_to_bottom"
		outerBlock.autoHeight = true
		outerBlock.autoWidth = true

    local title = outerBlock:createLabel{ id = tes3ui.registerID("crelClassHeading"), text = "Select class:" }
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

	---------------------MENU BLOCK: class list

    local classListBlock = innerBlock:createVerticalScrollPane{ id = tes3ui.registerID("crelClassListBlock") }
		classListBlock.layoutHeightFraction = 1.0
		classListBlock.minWidth = 200
		classListBlock.autoWidth = true
		classListBlock.paddingAllSides = 4
		classListBlock.borderRight = 6

	---------------------FUNCTION: sort class list alphabetically

    local sort_func = function(a, b)
        return string.lower(a.name) < string.lower(b.name)
    end

    for _, class in pairs(classList) do
        table.insert(this.sortedClassList, class)
    end
    table.sort(this.sortedClassList, sort_func)

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

    ---------------------MENU CONTENT: classes
    for _, class in pairs(this.sortedClassList) do
        local classButton = classListBlock:createTextSelect{ id = tes3ui.registerID("crelClassBlock"), text = class.name }
        classButton.autoHeight = true
        classButton.layoutWidthFraction = 1.0
        classButton.paddingAllSides = 2
        classButton.borderAllSides = 2
		classButton.borderRight = 0
        classButton:register("mouseClick", function() clickedClass(class) end )
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
        descriptionBlock.height = 145
        descriptionBlock.width = 400
        descriptionBlock.borderRight = 4
        descriptionBlock.flowDirection = "top_to_bottom"
        descriptionBlock.paddingAllSides = 10

        local descriptionHeader = descriptionBlock:createLabel{ id = classDescriptionHeaderID, text = ""}
        descriptionHeader.color = tes3ui.getPalette("header_color")

        local descriptionText = descriptionBlock:createLabel{id = classDescriptionID, text = ""}
        descriptionText.wrapText = true
    end

	----------------------------MENU BLOCK: class specialization and attributes

	local classInfoBlock = rightBlock:createThinBorder()

    do
		classInfoBlock.autoWidth = true
		classInfoBlock.autoHeight = true
        classInfoBlock.flowDirection = "top_to_bottom"
        classInfoBlock.paddingAllSides = 0
		classInfoBlock.paddingTop = 6
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

	local classAttrBlock = classInfoBlock:createThinBorder()
	do
		classAttrBlock.autoHeight = true
		classAttrBlock.width = 400
		classAttrBlock.paddingAllSides = 10
		classAttrBlock.borderRight = 6

		local attrHeader = classAttrBlock:createLabel{ id = classAttrHeaderID, text = this.attrHeaderText}
        attrHeader.color = tes3ui.getPalette("header_color")

        classAttrBlock:createLabel{id = classAttrTextID, text = ""}
	end

	----------------------------MENU BLOCK: class major/minor skills

	local skillBlock

    do
        skillBlock = rightBlock:createBlock()
		skillBlock.autoWidth = true
		skillBlock.autoHeight = true
        skillBlock.flowDirection = "left_to_right"
        skillBlock.paddingAllSides = 0
		skillBlock.paddingTop = 6
    end

    local classMajorSkillBlock = skillBlock:createThinBorder()
	do
		classMajorSkillBlock.height = 140
		classMajorSkillBlock.width = 127
		classMajorSkillBlock.paddingAllSides = 10
		classMajorSkillBlock.borderRight = 3
		classMajorSkillBlock:createLabel{id = majorSkillTextID, text = ""}
	end

	local classMinorSkillBlock = skillBlock:createThinBorder()
	do
		classMinorSkillBlock.height = 120
		classMinorSkillBlock.width = 197
		classMinorSkillBlock.paddingAllSides = 10
		classMinorSkillBlock.borderLeft = 3
		classMinorSkillBlock:createLabel{id = minorSkillTextID, text = ""}
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

    classMenu:updateLayout()

    tes3ui.enterMenuMode(classMenuID)
    --noBGButton:triggerEvent("mouseClick")
end

local optionsMenuID = tes3ui.registerID("crelOptionsMenu")

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

	local factionMenu = mwse.mcm.createDropdown( outerOptionsBlock,
        {
            label = "Faction",
            options = {    --TEST
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
				--{ label = "", value = ""},
				{ label = "East Navy", value = "T_Mw_ImperialNavy"},
				{ label = "Imperial Archaeological Society", value = "T_Glb_ArchaeologicalSociety"},
				--[[				{ label = "", value = ""},
				{ label = "Niben Hierophants", value = "T_Cyr_NibenHierophants"},
				{ label = "Imperial Curia", value = "T_Cyr_ImperialCuria"},
								{ label = "", value = ""},
				{ label = "", value = ""},
				{ label = "", value = ""},
								{ label = "", value = ""},
				{ label = "", value = ""},
				{ label = "", value = ""}]]
            },
            variable = mwse.mcm.createTableVariable{
                id = "pcFaction",
                table = this
            }
        }
    )

	tes3ui.enterMenuMode(optionsMenuID)

end


--[[
page:createDropdown{
	label = "Cell lighting value override presets. The override values are read from overrides.lua, and can be different for each cell.",
	options = {
		{ label = "NONE", value = nil},
		{ label = "True Lights and Darkness", value = "TLaD"},
		{ label = "di.Still.ed Lights", value = "DL"},
	},
	variable = mwse.mcm.createTableVariable{
            id = "useOverrides",
            table = config
        }
	}]]



--[[
local crelStart001 = {
	title = "Arrived by boat",
	items = {},
	spells = {},
	blockItems = false, --
	blockSpells = false,
	dependencies = {}, --mods needed for this
	requirements = {}, -- player faction/race/etc.
	locations = {
		loc1 = {"", x, y, z, rotation},
		loc2 = {"", x, y, z, rotation},
		loc2 = {"", x, y, z, rotation},
		},
	callback = start001Function
}
	]]

return this