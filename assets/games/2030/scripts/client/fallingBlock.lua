

local startPosition = object.position


function Begin()
    if isHost then
        while true do
            object.position = Vector3.New(startPosition.x, object.position.y, startPosition.z)
            object.rotation = Vector3.New(0, 0, 0)
            object.physics.velocity = Vector3.New(0, 0, 0)
            object.physics.angularVelocity = Vector3.New(0, 0, 0)
            object.physics.gravity = true
            wait(0.8)

            object.physics.gravity = false
            object.physics.velocity = Vector3.New(0, 9, 0)
            wait(0.4)
        end
    end
end

function OnTouchBegin(wildcard)
    if isHost then
        if IsCharacter(wildcard) then
            wildcard.player.Respawn()
        end
    else
        if IsCharacter(wildcard) then
            local respawnTable = {}
            respawnTable["respawnPlayerNetId"] = GetLocalPlayer().netId
            object.NetMessagePlayer(GetHostPlayer(), respawnTable)
        end
    end
end

function OnNetMessage(data)
    if isHost then
        if data["respawnPlayerNetId"] then
            local player = GetPlayerByNetId(data["respawnPlayerNetId"])
            if IsValid(player) then
                player.Respawn()
            end
        end
    end
end