function OnInteracted(wildcard)
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