local corel = PartByName("core light")
local speed = 1

function Update()
    corel.angles = corel.angles + newVector3(0, speed, 0)
end
