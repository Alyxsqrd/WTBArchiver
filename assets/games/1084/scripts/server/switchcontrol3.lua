local a1 = GetObjectById(1473)
local a2 = GetObjectById(1472)
local a3 = GetObjectById(1471)
local a4 = GetObjectById(675)

local onrot = Vector3.New(325, 7, 90)
local offrot = Vector3.New(307.895, 187, 270)
object.netTable["ison3"] = 5

function Begin()
    a1.rotation = onrot
    a2.rotation = onrot
    a3.rotation = onrot
    a1.position = Vector3.New(18.2333, 30.0364, 86.9202)
    a2.position = Vector3.New(18.4904, 29.8685, 87.1268)
    a3.position = Vector3.New(18.0636, 29.8686, 87.1792)
end

function OnTouchBegin()
    if object.netTable["ison3"] == 5 then
        a1.rotation = offrot
        a2.rotation = offrot
        a3.rotation = offrot
        a1.position = Vector3.New(18.2297, 29.5848, 86.8912)
        a2.position = Vector3.New(18.4859, 29.7629, 87.0903)
        a3.position = Vector3.New(18.2297, 29.5848, 86.8912)
        a4.worldText.text = "Offline"
        a4.worldText.color = Color.New(245, 0, 0)
        object.netTable["ison3"] = 0
    elseif object.netTable["ison3"] == 0 then
        a1.rotation = onrot
        a2.rotation = onrot
        a3.rotation = onrot
        a1.position = Vector3.New(18.2333, 30.0364, 86.9202)
        a2.position = Vector3.New(18.4904, 29.8685, 87.1268)
        a3.position = Vector3.New(18.0636, 29.8686, 87.1792)
        a4.worldText.color = Color.New(0, 255, 0)
        a4.worldText.text = "Online"
        object.netTable["ison3"] = 5
    end
end