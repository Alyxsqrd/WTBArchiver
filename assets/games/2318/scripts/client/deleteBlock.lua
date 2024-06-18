function OnMouseClick()
    Event.BroadcastToServer("setDelete",GetLocalCharacter().netId)
end