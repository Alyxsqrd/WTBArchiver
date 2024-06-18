local Lobby = PartByName("Lobby")

function StartCollision(player)
    if player == LocalPlayer() then
        NetMessageAll("Eliminated", {})
        player.position = Lobby.position + newVector3(0, Lobby.size.y / 2, 0)
	elseif player.name == "Map" then
		player.frozen = false
    end
end