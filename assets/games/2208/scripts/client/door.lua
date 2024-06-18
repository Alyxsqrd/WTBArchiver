function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        this.RunOnServer("OpenDoor")
    end
end

function OpenDoor()
    object.visible.enabled = false
    object.collider.enabled = false
    wait(2)
    object.visible.enabled = true
    object.collider.enabled = true
end