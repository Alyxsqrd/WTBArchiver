function OnInteracted(interactor)
this.RunOnServer("OnNetMessage", interactor)
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