local alarm = PartByName("alarm")
local speed = 1
local started = false
local temp = 700
function Start()
    CreateTimer("Delay", 1)
end

function Update()
    if started then
        alarm.angles = alarm.angles + newVector3(0, speed, 0)
    end
end

function TimerEnd(name)
if temp < 970 then
CreateTimer("Delay", 1)
temp = temp + 1
end
if temp == 970 then
    if name == "Delay" then
        started = true
    end
end

end