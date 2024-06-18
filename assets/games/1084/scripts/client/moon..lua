function StartCollision(player)
local panelPos = newVector2(10,35);
local panelSize = newVector2(80,60);
local panel = MakeUIPanel(panelPos, panelSize, panel);

local buttonPos = newVector2(5,5);
local buttonSize = newVector2(70,30);
local button = MakeUIButton(buttonPos, buttonSize, "launch to moon", panel);
button.name = "h";

function OnUIButtonClick(clickedObject, player)
    if (clickedObject.name == "h") then
       LocalPlayer().position = newVector3(242.559,127,-2526.321)
    end
end
end