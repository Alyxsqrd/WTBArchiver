function OnInteracted(interactor)
this.RunOnServer("SetCheckpoint", interactor)
end

function SetCheckpoint(player)
    local checkpointManager = GetObjectByName("CheckpointManager")
    if IsValid(checkpointManager) then
        -- only update the checkpoint if they aren't already on this checkpoint
        if not checkpointManager.netTable["player"..player.netId] or checkpointManager.netTable["player"..player.netId] ~= object.id then
            checkpointManager.netTable["player"..player.netId] = object.id
            -- let the player know that they reached a checkpoint
            player.SendSystemChat("Absolutely!")
        end
    end
end