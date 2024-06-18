local alarmspeaker = GetObjectByName("alarmcontrolroom")
local started = false
local b = GetObjectById(244)

function Begin()
  while true do
    wait(1)
    timecount()
  end
end

function timecount()
  local temp = b.netTable["temp"]
    if temp < 970 then
      alarmspeaker.sound.Pause()
    end
    if temp >= 970 then
      started = true
      alarmsoundon()
    end
end
  
function alarmsoundon()
      alarmspeaker.sound.Play()
end