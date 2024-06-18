local used = false


function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) and not used then
        used = true
        GetObjectByName("The Sun").light.brightness = 0.4
        WorldSettings.skybox = "night-dark"
    end
end