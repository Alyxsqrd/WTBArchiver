

function Begin()
    EnableLock()

    branch("Spin")
end

function OnInteracted(character)
    object.sound.Play()

    if (IsCharacter(character)) then
        if (character.HasItem(object.name .. " Key")) then
            Event.Broadcast("Unlock" .. object.name)
            character.RemoveItem(object.name .. " Key")
            
            PlayOneShot(15, 1, 1)
            DisableLock()
        else
            character.player.SendSystemChat("I think I'll need the " .. object.name .. " Key for this lock.")
        end
    end
end

function EnableLock()
    object.renderer.visible = true
    object.interactable.visible = true
    Event.Broadcast(object.name .. "LockClose")
end

function DisableLock()
    object.renderer.visible = false
    object.interactable.visible = false
    Event.Broadcast(object.name .. "Lock")
end

function Spin()
    while true do
        waitPhysicsTick(1)
        object.rotation = object.rotation + Vector3.New(0, 1, 0)
    end
end