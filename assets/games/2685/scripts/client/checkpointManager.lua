

function OnCharacterSpawn(character)
    -- as the host, we teleport players that have just respawned to their checkpoint
    if isHost then
        local playerNetId = character.player.netId
        if object.netTable["player"..playerNetId] then
            local checkpointObjectId = object.netTable["player"..playerNetId]
            character.position = GetObjectById(checkpointObjectId).position
        end
    end
end

function OnPlayerLeave(player)
    -- if a player leaves, we need to forget their checkpoint in case the netId is used again
    if isHost then
        if object.netTable["player"..player.netId] then
            object.netTable["player"..player.netId] = nil
        end
    end
end