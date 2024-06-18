local Lobby = PartByName("Lobby")

function StartCollision(player)
    if player == LocalPlayer() then
        NetworkSendToHost("Eliminated", {})
        player.position = Lobby.position + newVector3(0, Lobby.size.y / 2, 0)
    end
end