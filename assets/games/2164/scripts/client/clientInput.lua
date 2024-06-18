
function Begin()
    player = GetLocalPlayer()
end

function Tick()
    if Input.KeyPressed("F") then
        netTable = {"ballThrow", GetLocalPlayer().netId}
        GetObjectByName("ballThrower").NetMessagePlayer(GetHostPlayer(), netTable)
    end
end