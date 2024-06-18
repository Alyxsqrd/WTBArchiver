-- Important stuff
	local WM_Title = "Prison Life Remastered"
	local WM_Version = "v0.18"
	local WM_Credits = "Built by Alyx (binary#1337) | Original game by Aesthetical"


-- Controls window
	local controls = MakeUIWindow(newVector2(180, 10), newVector2(170, 128), "Controls")
	MakeUIText(newVector2(10, 40), newVector2(140, 30), "Shift (hold) - Sprint", controls)


-- Credits window
	local credits = MakeUIWindow(newVector2(355, 10), newVector2(210, 128), "Credits")

	MakeUIText(newVector2(10, 40), newVector2(210, 30), "Alyx - Creator", credits)
	MakeUIText(newVector2(10, 54), newVector2(210, 30), "Carocrazy132 - Scripting", credits)
	MakeUIText(newVector2(10, 68), newVector2(210, 30), "Quantum - Cell doors/treadmill script", credits)
	MakeUIText(newVector2(10, 82), newVector2(210, 30), "napie - Sprint script", credits)


-- Cell doors toggle
	local doorsButton = MakeUIButton(newVector2(29, 64), newVector2(112, 24), "Open/close doors")
	doorsButton.name = "Toggle doors button"


-- Version info
	local colorBack = newColor(0, 0, 0, 0.25)
	local colorFront = newColor(1, 1, 1, 0.25)

	local smallTitle = MakeUIText(newVector2(ScreenSize().x - 334, ScreenSize().y - 61), newVector2(250, 28), WM_Title)
	smallTitle.textColor = colorBack
	smallTitle.textSize = 24
	smallTitle.textAlignment = "BottomRight"

	local smallTitle2 = MakeUIText(newVector2(ScreenSize().x - 335, ScreenSize().y - 62), newVector2(250, 28), WM_Title)
	smallTitle2.textColor = colorFront
	smallTitle2.textSize = 24
	smallTitle2.textAlignment = "BottomRight"

	local verNum = MakeUIButton(newVector2(ScreenSize().x - 79, ScreenSize().y - 60), newVector2(58, 26), WM_Version)
	verNum.color = newColor(0, 0, 0, 0.1)
	verNum.textColor = colorBack
	verNum.textSize = 14

	local verNum2 = MakeUIButton(newVector2(ScreenSize().x - 80, ScreenSize().y - 61), newVector2(58, 26), WM_Version)
	verNum2.color = newColor(1, 1, 1, 0.1)
	verNum2.textColor = colorFront
	verNum2.textSize = 14

	local credText = MakeUIText(newVector2(ScreenSize().x - 331, ScreenSize().y - 33), newVector2(312, 14), WM_Credits)
	credText.textColor = colorBack
	credText.textSize = 12
	credText.textAlignment = "BottomRight"

	local credText2 = MakeUIText(newVector2(ScreenSize().x - 332, ScreenSize().y - 34), newVector2(312, 14), WM_Credits)
	credText2.textColor = colorFront
	credText2.textSize = 12
	credText2.textAlignment = "BottomRight"


local doors = PartsByNames({"Cell door", "Cell door bar"})

local function ToggleCells()
	for i, door in ipairs(doors) do
		door.table.moving = true
	end
end

function OnUIButtonClick(button)
	if button.name == "Toggle doors button" then
		if IsHost then
			ToggleCells()
		else
			NetworkSendToHost("RequestCellsToggle", {})
		end
	end
end

function NetworkStringReceive(player, name, data)
	if IsHost and name == "RequestCellsToggle" then
		ToggleCells()
	end
end