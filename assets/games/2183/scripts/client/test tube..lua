local spawntime = PartByName("time in spawn")
local spawntime1 = PartByName("time1")
local temperature = 300

function Start()
local temperature = 300
    CreateTimer("Increase", 1)
end

function TimerEnd(name)
if temperature == 300 then
Start()
end
    if name == "Increase" then
        temperature = temperature - 1
        spawntime.text.text = temperature .. "s"
spawntime1.text.text = temperature .. "s"
if temperature == 0 then
 temperature = temperature + 300
CreateTimer("Increase", 1)
  elseif temperature < 300 then
            CreateTimer("Increase", 1)
        end
    end
end
