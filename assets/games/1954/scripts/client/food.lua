

function Begin()
    object.localTable["clicked"] = false
    object.localTable["complete"] = false
end

function OnMouseClick()
    object.localTable["clicked"] = true
    CheckAll()
end

function CheckAll()
    for i,v in pairs(GetObjectsByName("Food")) do
        if v.localTable["clicked"] == false then
            return
        end
    end
    
    if object.localTable["complete"] == false then
        for i,v in pairs(GetObjectsByName("Food")) do
            v.localTable["complete"] = true
        end

        Event.Broadcast("DinnerPuzzleComplete")
        
        PlayOneShot(79, 1, 1)
        PlayOneShot(23, 0.5, 0.25)
        GetLocalPlayer().SendSystemChat("[The sounds of machinery can be heard in the walls nearby]")
    end
end