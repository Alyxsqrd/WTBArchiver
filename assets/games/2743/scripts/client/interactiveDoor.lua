function OnInteracted(interactor)
this.RunOnServer("OpenDoor", interactor)
end

function OpenDoor()
    object.renderer.visible = false
    object.collider.enabled = false
    object.sound.Play()
    wait(5)
    object.renderer.visible = true
    object.collider.enabled = true
    object.interactable.Remove()
end