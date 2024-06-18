local alarm = GetObjectByName("alarm")
local alarm2 = GetObjectByName("alarm2")
local alarm3 = GetObjectByName("aal")
local speed = 1
local started = false
local b = GetObjectById(244)

function Begin()
  while true do
    wait(1)
    timecount()
  end
end

function Tick()
  if started then
    alarm.rotation = alarm.rotation + Vector3.New(0, speed, 0)
    alarm2.rotation = alarm2.rotation + Vector3.New(0, speed, 0)
    alarm3.rotation = alarm3.rotation + Vector3.New(0, 0, speed)
  end
end

function timecount()
  local temp = b.netTable["temp"]
  if temp < 970 then
     started = false
  end
  if temp >= 970 then
    started = true
  end
end
