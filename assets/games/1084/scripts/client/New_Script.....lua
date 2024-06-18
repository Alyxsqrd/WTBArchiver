function StartCollision(player)
local panelPos = newVector2(10,35);
local panelSize = newVector2(80,60);
local panel = MakeUIPanel(panelPos, panelSize, panel);

local buttonPos = newVector2(5,5);
local buttonSize = newVector2(70,30);
local button = MakeUIButton(buttonPos, buttonSize, "launch to iss", panel);
button.name = "hu";

function OnUIButtonClick(clickedObject, player)
    if (clickedObject.name == "hu") then
       LocalPlayer().position = newVector3(72.35185,1131.61,-85.76331)
    end
end
end