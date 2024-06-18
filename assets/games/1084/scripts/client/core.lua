local This = GetObjectByName("core")
local speed = 1
function LateTick()
    This.rotation = This.rotation + Vector3.New(0, speed, speed)
end