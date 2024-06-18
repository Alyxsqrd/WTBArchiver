local This = GetObjectByName("fansys")
local speed = 5
function LateTick()
    This.rotation = This.rotation + Vector3.New(0, speed, 0)
end