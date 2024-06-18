local spawntime = PartByName("time in spawn")
local spawntime1 = PartByName("time1")
local timeleft = 300
local alarm = PartByName("alarm")
local alarm2 = PartByName("alarm2")
local a = PartByName("c")
local f = PartByName("f")
local speed = 1
local started = false
local coolant = PartByName("coolant")
local c = 700
local coolant% = 17

function Start()
    CreateTimer("in", 1)
    check()
end

function StartCollision()
    CreateTimer("fill", 1)
end

function TimerEnd(name)
    if name == "In" then
        if  coolant% > 0 then
            timeleft = timeleft + 1
            coolant.size = coolant.size + newVector3(0,-0.10,0)
            c = c + 1
            a.text.text = c .. "c"
            f.text.text = (c * 9 / 5) + 32 .. "f"
            Start()
        elseif  coolant% == 0 then
            timeleft = timeleft - 1
            c = c + 1
            a.text.text = c .. "c"
            f.text.text = (c * 9 / 5) + 32 .. "f"
            Start()
        end
    end
end

function TimerEnd(name)
    if name == "fill" then
        if coolant% == 17 then

        elseif coolant% == 0 then

        elseif coolant% < 17 and > 0 then
            coolant.size = coolant.size + newVector3(0,0.20,0)
            coolant% = coolant% + 0.20
        end
    end
end

function Explode()
    local pos = newVector3(3.39,19.39002,3.39);
    Explode(pos, 1000, 99999, true, false)
    c = c - 300
    coolant.size = coolant.size = newVector3(56.0002,17,88.00061)
    Start()
end

function Update()
    if started then
        alarm.angles = alarm.angles + newVector3(0, speed, 0)
       alarm2.angles = alarm2.angles + newVector3(0, speed, 0)
    end
end

function Check()
    if c == 970 then
        if name == "Delay" then
            started = true
        end
    elseif c == 1000 then
        started = false
    end
end
