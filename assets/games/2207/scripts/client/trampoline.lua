

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        this.RunOnServer("Bounce", wildcard)
    end
end

function Bounce(character)
    character.Unground() -- this detaches the character from the ground so we can shoot them in the air

    local force = Vector3.New(0, 10, 0)
    character.Impulse(force)
end