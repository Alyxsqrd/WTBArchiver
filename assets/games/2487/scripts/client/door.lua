function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then 
        this.RunOnServer("OpenDoor")
        wildcard.forceField = false
        --wildcard.position = Vector3.New(5,2,-8)
    end 
end 

function OpenDoor()
    object.renderer.visible = false
    object.collider.enabled = false
    wait(2)
    object.renderer.visible = true
    object.collider.enabled = true
end

