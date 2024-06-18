
function OnNetMessage(netTable)
    if netTable[1] == "respawn" then
        RespawnPlayer(GetPlayerByNetId(netTable[2]))
    end
end

function RespawnPlayer(passedPlayer)
    print('respawn player')
    passedPlayer.character.Kill()
end