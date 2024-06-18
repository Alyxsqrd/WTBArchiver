local timer = nil
local timerText = nil

local uiManager = PartByName("UI Manager")

function Start()
	timer = MakeUIText(newVector2(ScreenSize().x/2, 200), newVector2(600, 200), "timer");
	timer.textSize = 60
	uiManager.table["timer"] = timer

	timerText = MakeUIText(newVector2(ScreenSize().x/2, 100), newVector2(600, 100), "text");
	timerText.textSize = 60
	uiManager.table["timerText"] = timerText
end