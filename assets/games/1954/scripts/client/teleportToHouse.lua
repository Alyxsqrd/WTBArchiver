

function OnTouchBegin(wildcard)
    if (IsCharacter(wildcard)) then
        local target = GetObjectByName("HouseTeleportIn")
        if (IsValid(target)) then
            wildcard.position = target.position
            wildcard.rotation = target.forwardDirection
        end

        Event.Broadcast("StartLightning")
    end
end