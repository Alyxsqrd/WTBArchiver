

local speed = 99;
local startPosition = object.position


function Begin()
    if isHost then
        while true do
            wait(2)
            object.position = startPosition
            object.physics.angularVelocity = Vector3.New(0, 0, 0)
            object.physics.angularVelocity = Vector3.New(0, speed, 0)
            object.physics.velocity = Vector3.New(0, 0, 0)
        end
    end
end