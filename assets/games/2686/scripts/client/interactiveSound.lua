function OnInteracted(interactor)
this.RunOnServer("OpenDoor", interactor)
end

function OpenDoor()
    object.renderer.color = D24646
    object.collider.enabled = false
    wait(2)
    object.renderer.visible = true
    object.collider.enabled = true
end