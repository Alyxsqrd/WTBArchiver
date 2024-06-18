local sun = PartByName("sun")
local speed = 1
function Update()
    sun.angles = sun.angles + newVector3(-speed, 0, 0)
end
