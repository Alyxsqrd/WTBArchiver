local used = false


function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) and not used then
        used = true
        GetObjectByName("The Sun").light.enabled = false
    end
end