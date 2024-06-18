local coolantpool = GetObjectByName("coolantpool")
local coolantpooltext = GetObjectByName("am")
local laser1 = GetObjectById(473)
local laser2 = GetObjectById(477)
local newsize = 40


function Begin()
    object.netTable["coolant"] = 100
    object.netTable["temp"] = 700
    print("started")
    while true do
        wait(1)
        timecount()
    end
end

function OnTouchContinue()
    wait(1)
    if object.netTable["coolant"] < 100 then
        object.netTable["coolant"] = object.netTable["coolant"] + 1
    end
end

function timecount()
    newsize = object.netTable["coolant"] / 2.5
    if object.netTable["coolant"] > 0 then
        laser1.renderer.visible = true
        object.netTable["stat"] = false
        laser2.renderer.visible = true
        coolantpool.size = Vector3.New(57.0905, newsize, 93.0413)
        if object.netTable["temp"] > 500 then
            object.netTable["temp"] = object.netTable["temp"] - 1
        end
        object.netTable["coolant"] = object.netTable["coolant"] - 1
        coolantpooltext.worldText.text = object.netTable["coolant"] .. "% Full"
    elseif object.netTable["coolant"] <= 0 then
        object.netTable["stat"] = true
        laser1.renderer.visible = false
        laser2.renderer.visible = false
        object.netTable["temp"] = object.netTable["temp"] + 1
        coolantpooltext.worldText.text = object.netTable["coolant"] .. "% Full"
    end
end


