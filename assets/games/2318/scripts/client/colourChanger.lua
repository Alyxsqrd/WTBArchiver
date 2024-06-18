function OnMouseClick()
    Event.BroadcastToServer("changeColour",object.renderer.color,GetLocalCharacter().netId)
end