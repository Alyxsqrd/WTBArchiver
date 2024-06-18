
function OnNetMessage(message)
    if message[1] == 'respawn' then
        ply = GetPlayerByNetId(message[2])
        GetObjectByName("GameManager").localTable[ply.netId .."alive"] = false
        --GetCharacterFromPlayer(ply).position = GetObjectByName("Respawn").position
        if ply.character.alive == true then
            ply.character.Kill()
        end
    end
end

function OnPlayerJoin(playa)
    GetObjectByName("GameManager").localTable[playa.netId .. "wins"] = 0
end