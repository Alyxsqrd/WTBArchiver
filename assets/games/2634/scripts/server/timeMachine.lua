function Begin()
    built = false
    object.interactable.enabled = false
    object.renderer.visible = false
    object.collider.enabled = false
    Event.Bind(this,"allScrapCollected")
end

function allScrapCollected()
    object.interactable.enabled = true
end

function OnInteracted()
    if(built) then
        object.interactable.visible = false
        GetAllAliveCharacters()[1].position = GetObjectByName("BlackBoxOut").position
        Event.Broadcast("BEGINFINALCOUNTDOWN")
    else
        object.renderer.visible = true
        object.collider.enabled = true
        built = true
        object.interactable.holdDuration = 1
    end
end