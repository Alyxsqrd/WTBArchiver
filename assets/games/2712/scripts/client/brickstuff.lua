local bricks = GetObjectsByName("Brick")
local originalPositions = {}
local originalRotations = {}

for k, brick in pairs(bricks) do
    originalPositions[k] = brick.position
    originalRotations[k] = brick.rotation
    brick.physics.gravity = true
end

function OnPlayerChat(ply, msg)
    if string.lower(msg) == "reset" then
        for k, brick in pairs(bricks) do
            brick.physics.velocity = Vector3.New(0, 0, 0)
            brick.rotation = originalRotations[k]
            brick.position = originalPositions[k]
        end
    end
end