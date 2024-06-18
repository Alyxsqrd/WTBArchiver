function StartCollision(player)
   local windowPos = newVector2(0,0);
local windowSize = newVector2(100,100);
local window = MakeUIWindow(windowPos, windowSize, "myWindow");

local panelPos = newVector2(10,35);
local panelSize = newVector2(1000,1000);
local panel = MakeUIPanel(panelPos, panelSize, panel);

local buttonPos = newVector2(5,5);
local buttonSize = newVector2(70,30);
local button = MakeUIButton(buttonPos, buttonSize, "trun off", panel);
button.name = "off";

function OnUIButtonClick(clickedObject)
    if (clickedObject.name == "off") then
       panel.enabled.enabled = false
    end
end

end

