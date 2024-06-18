local used = false


function Begin()
    branch("Spin")

    Event.BindFunction(this, "Unlock" .. object.name, "Unlocked")
end

function OnCharacterSpawn(character)
    if not object.interactable.visible and not used then
        character.GrantItem(object.name .. " Key")
    end
end

function OnInteracted(character)
    if (IsCharacter(character)) and object.interactable.visible then
        character.GrantItem(object.name .. " Key")
        object.sound.Play()
        DisableGranting()
    end
end

function EnableGranting()
    object.renderer.visible = true
    object.interactable.visible = true
    if (IsLight(object.light)) then
        object.light.enabled = true
    end
end

function DisableGranting()
    object.renderer.visible = false
    object.interactable.visible = false
    if (IsLight(object.light)) then
        object.light.enabled = false
    end
end

function Unlocked()
    used = true
end

function Spin()
    while true do
        waitPhysicsTick(1)
        object.rotation = object.rotation + Vector3.New(0, 1, 0)
    end
end