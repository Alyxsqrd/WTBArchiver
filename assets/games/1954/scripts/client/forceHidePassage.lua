

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        Event.Broadcast("CloseBalcony")
    end
end