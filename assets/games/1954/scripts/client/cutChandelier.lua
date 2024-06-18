

function Begin()
    Event.Bind(this, "RevealUpsideDown")
    object.localTable["cut"] = false
end

function RevealUpsideDown()
    object.interactable.visible = true
end

function OnInteracted(character)
    object.interactable.visible = false
    object.localTable["cut"] = true

    if (object.name == "Chand1") then
        for i,v in pairs(GetObjectsByName("ChandCut1")) do
            DeleteObject(v)
        end
        Event.Broadcast("Chand1Light")
    end

    if (object.name == "Chand2") then
        for i,v in pairs(GetObjectsByName("ChandCut2")) do
            DeleteObject(v)
        end
        Event.Broadcast("Chand2Light")
    end

    if GetObjectByName("Chand1").localTable["cut"] and GetObjectByName("Chand2").localTable["cut"] then
        Event.Broadcast("CompleteRevealLampPuzzle")
        PlayOneShot(22, 1 , 0.66)
        PlayOneShot(79, 1, 1)
    end
end