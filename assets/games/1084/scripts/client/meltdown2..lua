local spawntime = GetObjectByName("time in spawn")
local spawntime1 = GetObjectByName("time1")
local timeleft = 300
local alarm = GetObjectByName("alarm")
local alarm2 = GetObjectByName("alarm2")
local alarm3 = GetObjectByName("aal")
local a = GetObjectByName("c")
local f = GetObjectByName("f")
local This = GetObjectByName("fansys")
local fan_speed = 5
local speed = 1
local started = false
local coolant = GetObjectByName("coolant")
local c = 700
local coolant% = 17

function Begin()
    wait(1)
    TimerEnd("in")
    check()
end

function OnTouchBegin()
    wait(1)
    TimerEnd("fill")
end

function TimerEnd(name)
    if name == "In" then
        if  coolant% > 0 then
            timeleft = timeleft + 1
            coolant.size = coolant.size + Vector3.New(0,-0.10,0)
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

function Meltdown()
    c = c - 300
    coolant.size = coolant.size = newVector3(56.0002,17,88.00061)
    Start()
end

function Tick()
    if started then
        alarm.rotation = alarm.rotation + Vector3.New(0, speed, 0)
        alarm2.rotation = alarm2.rotation + Vector3.New(0, speed, 0)
        alarm3.rotation = alarm3.rotation + Vector3.New(0, speed, 0)
    end
end

function LateTick()
    This.rotation = This.rotation + Vector3.New(0, fan_speed, 0)
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
