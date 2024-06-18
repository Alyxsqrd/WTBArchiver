function OnPlayerJoin(player)
    player.SendSystemChat("Welcome to Rising Tides!")
    wait(3)
    player.SendSystemChat("The goal of the game is to outrun the rising waters, by jumping and climbing your way up the map!")
    wait(4.5)
    player.SendSystemChat("If you touch the water, you will be sent back to the lobby to wait for the next round to begin.")
    wait(4.5)
    player.SendSystemChat("Have fun and good luck!")
 end