local alarm = PartByName("rad")
local speed = 1

function Update()
    alarm.angles = alarm.angles + newVector3(0, speed, 0)
end

