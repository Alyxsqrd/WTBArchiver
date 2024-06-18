function Begin()
    Event.Bind(this,"resetScrap")
end

function OnInteracted()
    if(object.name == "hasGear") then
        Event.Broadcast("foundGear")
    end
    object.collider.enabled = false
    object.renderer.visible = false
    object.interactable.enabled = false
    object.interactable.visible = false
end

function resetScrap()
    object.collider.enabled = true
    object.renderer.visible = true
    object.interactable.enabled = true
    object.interactable.visible = true
end