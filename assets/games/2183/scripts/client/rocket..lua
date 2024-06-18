function Start()
local panelPos = newVector2(10,35);
local panelSize = newVector2(80,60);
local panel = MakeUIPanel(panelPos, panelSize, panel);

local buttonPos = newVector2(5,5);
local buttonSize = newVector2(70,30);
local button = MakeUIButton(buttonPos, buttonSize, "launch", panel);
button.name = "lu";

function OnUIButtonClick(clickedObject)
    if (clickedObject.name == "lu") then
       CreateTimer("launch", 1)
    end
end
end
function TimerEnd(name)
 local f = PartByName("rb")
local t = PartByName("thrust")
t.position = t.pisition + newVector3(0,3.62454460658166,0)
f.position = f.position + newVector3(0,33.62454460658166,0)
CreateTimer("launch", 0.1)
end

