function OnInteracted(interactor)
this.RunOnServer("OpenDoor", interactor)
end

function OpenDoor()
    object.renderer.visible = false
    object.collider.enabled = false
    wait(0.5)
    object.renderer.transparency = 50
    object.collider.enabled = false
    wait(0.5)
    object.renderer.transparency = 0
    object.collider.enabled = true
end