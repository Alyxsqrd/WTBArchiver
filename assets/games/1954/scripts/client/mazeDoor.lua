

function OnInteracted(character)
    object.sound.Play()
    wait(0.1)
    Event.Broadcast(object.name)
end