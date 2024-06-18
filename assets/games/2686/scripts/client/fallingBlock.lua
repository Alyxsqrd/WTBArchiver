

local startPosition = object.position


function Begin()
    if isHost then
        while true do
            object.position = Vector3.New(startPosition.x, object.position.y, startPosition.z)
            object.rotation = Vector3.New(0, 0, 0)
            object.physics.velocity = Vector3.New(0, 0, 0)
            object.physics.angularVelocity = Vector3.New(0, 0, 0)
            object.physics.gravity = true
            wait(2)

            object.physics.gravity = false
            object.physics.velocity = Vector3.New(0, 2, 0)
            wait(4.5)
        end
    end
end