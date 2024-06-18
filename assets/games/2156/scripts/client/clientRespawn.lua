function OnTouchBegin(char)
    if IsCharacter(char) then
        table = {"respawn", GetLocalPlayer().netId}
        GetObjectByName("NetRespawner").NetMessagePlayer(GetHostPlayer(), table)
    end
end