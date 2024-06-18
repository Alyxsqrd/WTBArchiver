local played = false


function OnTouchBegin(wildcard)
    if (IsCharacter(wildcard)) and not played then
        played = true
        Event.Broadcast(object.name)
    end
end