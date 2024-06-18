local played = false


function OnTouchBegin(wildcard)
    if (IsCharacter(wildcard)) and not played then
        played = true
        wildcard.player.SendSystemChat(object.name)
    end
end