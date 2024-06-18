local played = false


function OnTouchBegin(wildcard)
    if (IsCharacter(wildcard)) and not played then
        played = true
        PlayOneShot(object.sound.id, object.sound.volume, object.sound.pitch)
    end
end