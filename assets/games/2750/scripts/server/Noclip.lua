function OnPlayerChat(player, message)
    if player.username == "Rhino" then
            if message == "admin nc" then
            GetCharacterFromPlayer(player).SetNoClipMovement()
            else if message == "admin unc" or "admin unnc" then
            GetCharacterFromPlayer(player).SetNormalMovement()
            end
    end
end