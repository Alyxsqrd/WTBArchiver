function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        this.RunOnServer("heal", wildcard)
    end
end

function heal(character)
    print("healed " .. character.username)
    character.Heal(1)
end