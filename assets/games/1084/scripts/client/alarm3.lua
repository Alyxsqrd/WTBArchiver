local alarm = GetObjectByName("aal")
local speed = 1
local started = false
local temp = 700

function Begin()
  while true do
    wait(1)
    timecount()
  end
end

function Tick()
  if started then
    alarm.rotation = alarm.rotation + Vector3.New(0, speed, 0)
  end
end

function timecount()
  if temp < 970 then
     temp = temp + 1
  end
  if temp >= 970 then
    started = true
  end
end