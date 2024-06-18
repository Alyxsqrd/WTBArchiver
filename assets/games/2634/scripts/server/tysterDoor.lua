local open = false


function OnInteracted(character)
    if open then
        open = false

        object.renderer.visible = true
        object.collider.enabled = true

        local doorOpen = GetObjectByName(object.name .. "Open")
        doorOpen.renderer.visible = false
        doorOpen.collider.enabled = false
    else
        open = true

        object.renderer.visible = false
        object.collider.enabled = false

        local doorOpen = GetObjectByName(object.name .. "Open")
        doorOpen.renderer.visible = true
        doorOpen.collider.enabled = true
    end

    object.sound.Play()
end