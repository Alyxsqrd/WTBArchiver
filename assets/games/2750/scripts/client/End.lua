function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        if wildcard.health == 100 then
            this.RunOnServer("Congrats", wildcard)
        end
    end
end

function Congrats(character)
    character.Damage(1)
    SendSystemChatToAll(character.username .. " has reached the end!")
end