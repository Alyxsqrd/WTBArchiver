local cooldown = 3


function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        this.RunOnServer("Use", wildcard)
    end
end

function Use(character)
    if onCooldown then
        return
    end

    onCooldown = true

    character.Heal(100)
    object.renderer.color = Color.New(0,0,0)

    wait(cooldown)

    object.renderer.color = Color.New(0,1,0)

    onCooldown = false
end