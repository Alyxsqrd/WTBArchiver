function OnTouchBegin(wildcard)
    if IsObject(wildcard) then
        this.Run("KillCharacter", wildcard)
    end
end

function KillCharacter(character)
    object.Delete()
end