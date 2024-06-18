


function OnInteracted(character)
    Event.Broadcast("FrontDoor")
    object.sound.Play()
    object.interactable.visible = false
end