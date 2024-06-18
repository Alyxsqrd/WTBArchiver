local a1 = GetObjectById(1465)
local a2 = GetObjectById(1464)
local a3 = GetObjectById(1463)
local a4 = GetObjectById(682)

local onrot = Vector3.New(325, 7, 90)
local offrot = Vector3.New(307.895, 187, 270)
object.netTable["ison2"] = true

function Begin()
    a1.rotation = onrot
    a2.rotation = onrot
    a3.rotation = onrot
    a1.position = Vector3.New(17.3401, 30.0368, 87.0308)
    a2.position = Vector3.New(17.5971, 29.8682, 87.2369)
    a3.position = Vector3.New(17.1703, 29.8682, 87.2893)
end

function OnTouchBegin()
    if object.netTable["ison2"] == true then
        a1.rotation = offrot
        a2.rotation = offrot
        a3.rotation = offrot
        a1.position = Vector3.New(17.3364, 29.5848, 87.0008)
        a2.position = Vector3.New(17.5926, 29.7629, 87.1999)
        a3.position = Vector3.New(17.1658, 29.7629, 87.2523)
        a4.worldText.text = "Offline"
        a4.worldText.color = Color.New(245, 0, 0)
        object.netTable["ison2"] = false
    elseif object.netTable["ison2"] == false then
        a1.rotation = onrot
        a2.rotation = onrot
        a3.rotation = onrot
        a1.position = Vector3.New(17.3401, 30.0368, 87.0308)
        a2.position = Vector3.New(17.5971, 29.8682, 87.2369)
        a3.position = Vector3.New(17.1703, 29.8682, 87.2893)
        a4.worldText.text = "Online"
        a4.worldText.color = Color.New(0, 255, 0)
        object.netTable["ison2"] = true
    end
end