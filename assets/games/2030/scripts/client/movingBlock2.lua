

local startPosition = object.position


function Begin()
    if isHost then
        -- keep moving back and forth
        -- wait 5 seconds before switching directions
        while true do
            object.physics.velocity = Vector3.New(-13, 0, 0)
            object.physics.angularVelocity = Vector3.New(0, 0, 0)
            object.position = Vector3.New(object.position.x, startPosition.y, startPosition.z)
            object.rotation = Vector3.New(0, 0, 0)
            wait(0.5)

            object.physics.velocity = Vector3.New(13, 0, 0)
            object.physics.angularVelocity = Vector3.New(0, 0, 0)
            object.position = Vector3.New(object.position.x, startPosition.y, startPosition.z)
            object.rotation = Vector3.New(0, 0, 0)
            wait(0.5)
        end
    end
end