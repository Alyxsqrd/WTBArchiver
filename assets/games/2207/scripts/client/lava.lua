

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        this.RunOnServer("Kill", wildcard)
    end
end

function Kill(character)
    character.Kill()
end