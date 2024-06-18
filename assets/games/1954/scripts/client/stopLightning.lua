

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        Event.Broadcast("StopLightning")

        PlayOneShot(79, 1, 1)
        PlayOneShot(23, 0.5, 0.25)
    end
end