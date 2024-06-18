local This = PartByName("fansys")
local speed = 5
function FixedUpdate()
    This.angles = This.angles + newVector3(0, speed, 0)
end