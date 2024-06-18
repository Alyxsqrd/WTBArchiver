

local speed = 6;
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