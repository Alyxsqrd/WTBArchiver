local a1 = GetObjectById(755)
local a2 = GetObjectById(754)
local a3 = GetObjectById(753)
local a4 = GetObjectById(680)

local onrot = Vector3.New(325, 7, 90)
local offrot = Vector3.New(307.895, 187, 270)
object.netTable["ison1"] = true

function Begin()
    a1.rotation = onrot
    a2.rotation = onrot
    a3.rotation = onrot
    a1.position = Vector3.New(16.4524, 30.1425, 87.1866)
    a2.position = Vector3.New(16.701, 29.905, 87.3236)
    a3.position = Vector3.New(16.2742, 29.905, 87.376)
end

function OnTouchBegin()
    if object.netTable["ison1"] == true then
        a1.rotation = offrot
        a2.rotation = offrot
        a3.rotation = offrot
        a1.position = Vector3.New(16.4431, 29.5848, 87.1105)
        a2.position = Vector3.New(16.6993, 29.7629, 87.3096)
        a3.position = Vector3.New(16.2725, 29.7629, 87.362)
        a4.worldText.text = "Offline"
        a4.worldText.color = Color.New(245, 0, 0)
        object.netTable["ison1"] = false
    elseif object.netTable["ison1"] == false then
        a1.rotation = onrot
        a2.rotation = onrot
        a3.rotation = onrot
        a1.position = Vector3.New(16.4524, 30.1425, 87.1866)
        a2.position = Vector3.New(16.701, 29.905, 87.3236)
        a3.position = Vector3.New(16.2742, 29.905, 87.376)
        a4.worldText.text = "Online"
        a4.worldText.color = Color.New(0, 255, 0)
        object.netTable["ison1"] = true
    end
end