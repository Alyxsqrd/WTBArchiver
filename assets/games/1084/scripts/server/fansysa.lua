local This = GetObjectByName("fansys")
local a1 = GetObjectById(1473)

function LateTick()
    This.rotation = This.rotation + Vector3.New(0, a1.netTable["ison3"], 0)
end