

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        Event.Broadcast("KillCharacter", wildcard)
    end
end