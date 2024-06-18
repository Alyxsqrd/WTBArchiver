

function OnTouchBegin(wildcard)
    if (IsCharacter(wildcard)) then
        this.RunOnServer("KillCharacter", wildcard)
    end
end

function KillCharacter(character)
    character.Kill()
end