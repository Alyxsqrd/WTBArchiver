

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        local premade = CreatePremade("bouncy EYEBALL")
        premade.position = wildcard.position + Vector3.New(0, 5, 0)
    end
end