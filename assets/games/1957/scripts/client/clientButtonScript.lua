

function OnTouchBegin(touchingPlayer)
    local table = {"buttonPressed", "Unlock", object.id, touchingPlayer.username}
    object.parent.parent.NetMessagePlayer(GetHostPlayer(),table)
end
