function OnPlayerJoin()
    wait(1)
    local Player = GetLocalPlayer
    RunOnServer(message, Player)
end

function message()
    Player.SendSystemChat("Welcome to Market Sim! The goal of the game is to become the richest player. However, the market is always changing, and prices will fluctuate based on many factors, including how much of the stock is sold/bought at any given time. The exchange updates every 10 seconds, (6x faster than the NYSE,) so you can always stay up to date. Good luck!")
end