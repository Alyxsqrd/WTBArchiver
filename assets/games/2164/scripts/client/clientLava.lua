
function OnTouchBegin(touched)
    if IsCharacter(touched) then
        netTable = {"respawn", touched.player.netId}
        GetObjectByName("damageHandler").NetMessagePlayer(GetHostPlayer(), netTable)
    end
end