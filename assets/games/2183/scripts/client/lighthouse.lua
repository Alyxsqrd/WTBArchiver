local lighthouse_light = GetObjectById(7825)
local rotation_speed = 1


function Begin()
    print("phase 1 working")
end

function Tick()
    lighthouse_light.Angle =+ Vector3.Angle(0, rotation_speed, 0)
end
