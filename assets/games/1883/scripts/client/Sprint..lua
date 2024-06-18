local isRunning = false
local sprintKey = "left shift"
local startSpeed = 0;
local stamina = 100;
local staminaBar = nil;

function Start()
	startSpeed = LocalPlayer().speed;

	local staminaBarPanelPos = newVector2(ScreenSize.x/2-200,ScreenSize.y - 55);
	local staminaBarPanelSize = newVector2(408,48);
	local staminaBarPanel = MakeUIPanel(staminaBarPanelPos, staminaBarPanelSize);
	staminaBarPanel.color = newColor( 0.4, 0.4, 0.4, 1 );

	local staminaBarBGPos = newVector2(staminaBarPanelPos.x+4,staminaBarPanelPos.y+4);
	local staminaBarBGSize = newVector2(staminaBarPanelSize.x-8,staminaBarPanelSize.y-8);
	local staminaBarBG = MakeUIPanel(staminaBarBGPos, staminaBarBGSize);
	staminaBarBG.color = newColor( 0.2, 0.2, 0.2, 1 );

	local staminaBarPos = newVector2(staminaBarPanelPos.x+4,staminaBarPanelPos.y+4);
	local staminaBarSize = newVector2(staminaBarPanelSize.x-8,staminaBarPanelSize.y-8);
	staminaBar = MakeUIPanel(staminaBarBGPos, staminaBarBGSize);
	staminaBar.color = newColor( 0.8, 0.5, 0, 1 );
end

function Update()
	if (InputPressed(sprintKey)) then
		LocalPlayer().speed = startSpeed * 2;
		isRunning = true;
	end
	if (InputReleased(sprintKey)) then
		LocalPlayer().speed = startSpeed;
		isRunning = false;
	end
		
		
	if (isRunning) then
		stamina = stamina - 0.02;
		if (stamina <= 0) then
			LocalPlayer().speed = startSpeed;
			isRunning = false;
		end
	else
		stamina = stamina + 0.05
	end

	if (stamina > 100) then stamina = 100 end
	if (stamina < 0) then stamina = 0 end
	
	if (staminaBar != nil) then
		staminaBar.size = newVector2(stamina * 4, staminaBar.size.y);
	end
end
