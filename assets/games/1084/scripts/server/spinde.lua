local object = GetObjectById(1601)
local speed = 1

function Begin()
    print(Started)
end

function Tick()
    object.rotation = object.rotation + Vector3.New(0, speed, 0)
end