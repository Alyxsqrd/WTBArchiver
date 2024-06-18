function Begin()
    crosshairObj = GetObjectByName("Crosshair")
    players = {}
    crosshairs = {}
end

function OnPlayerJoin()
    players = GetAllPlayers()
    table.insert(crosshairs,crosshairObj.Duplicate())
end
function OnPlayerLeave()
    players = GetAllPlayers()
end

function Tick()
    print("hi")
    for i = 1,#(players)
        local character = players[i].character
        
        
    end
end