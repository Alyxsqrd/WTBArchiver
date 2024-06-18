function Begin()
    if isHost then
        while true do
            object.MoveTo(object.position + Vector3.New(0, 1, 0), 5)
            wait(5)
        end
    end
end

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        this.RunOnServer("KillCharacter", wildcard)
    end
end

function KillCharacter(character)
    character.Kill()
end