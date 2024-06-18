local completed = false
local revealed = false
local revealCompleted = false
local locked = false


function Begin()
    object.localTable["lamp"] = object.light.enabled

    Event.Bind(this, "CompleteLampPuzzle")
    Event.Bind(this, "RevealUpsideDown")
    Event.Bind(this, "CompleteRevealLampPuzzle")
end

function OnInteracted(character)
    if locked then
        return
    end

    if (object.light.enabled) then
        object.light.enabled = false
        object.localTable["lamp"] = false
    else
        object.light.enabled = true
        object.localTable["lamp"] = true
    end

    object.sound.Play()
    
    if not revealed then
        if not completed then
            CheckCompletion()
        end
    else
        if not revealCompleted then
            CheckRevealCompletion()
        end
    end
end

function CheckCompletion()
    for i,v in pairs(GetObjectsByName("LampOn")) do
        if not v.localTable["lamp"] then
            return
        end
    end

    for i,v in pairs(GetObjectsByName("LampOff")) do
        if v.localTable["lamp"] then
            return
        end
    end

    PlayOneShot(79, 1, 1)
    PlayOneShot(23, 0.5, 0.25)
    GetLocalPlayer().SendSystemChat("[The sounds of machinery can be heard in the walls nearby]")

    Event.Broadcast("CompleteLampPuzzle")
end

function CheckRevealCompletion()
    for i,v in pairs(GetObjectsByName("LampOn")) do
        if not v.localTable["lamp"] then
            return
        end
    end

    PlayOneShot(79, 1, 1)
    PlayOneShot(22, 1, 0.66)
    
    Event.Broadcast("CompleteRevealLampPuzzle")
end

function CompleteLampPuzzle()
    completed = true
end

function RevealUpsideDown()
    revealed = true
    object.light.enabled = true
    object.light.color = Color.red
end

function CompleteRevealLampPuzzle()
    locked = true
    object.light.enabled = false
end