

function OnTouchBegin(wildcard)
    if isHost then
        -- if we're the host and our character touches the checkpoint, update our checkpoint in the CheckpointManager
        if IsCharacter(wildcard) then
            SetCheckpoint(GetLocalPlayer())
        end
    else
        -- if we're not the host, we need to send a network message to the host to tell them that we touched this checkpoint
        -- the host will run OnNetMessage on their client with the data we send
        local checkpointUpdateTable = {}
        checkpointUpdateTable["playerNetId"] = GetLocalPlayer().netId
        object.NetMessagePlayer(GetHostPlayer(), checkpointUpdateTable)
    end
end

function OnNetMessage(data)
    -- if we recieved a request to update a player's checkpoint, then we should update the player's checkpoint in the CheckpointManager
    if isHost then
        if data["playerNetId"] then
            SetCheckpoint(GetPlayerByNetId(data["playerNetId"]))
        end
    end
end

function SetCheckpoint(player)
    local checkpointManager = GetObjectByName("CheckpointManager")
    if IsValid(checkpointManager) then
        -- only update the checkpoint if they aren't already on this checkpoint
        if not checkpointManager.netTable["player"..player.netId] or checkpointManager.netTable["player"..player.netId] ~= object.id then
            checkpointManager.netTable["player"..player.netId] = object.id
            -- let the player know that they reached a checkpoint
            player.SendSystemChat("You found an egg!")
        end
    end
end