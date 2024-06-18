function Begin()
    built = false
    object.interactable.enabled = false
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
        object.renderer.transparency = 0
        built = true
        object.interactable.holdDuration = 1
    end
end