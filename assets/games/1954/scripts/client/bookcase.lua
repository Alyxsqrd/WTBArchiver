local moving = false
local openedOnce = false


function Begin()
    Event.Bind(this, "CompleteSkulls")
    Event.Bind(this, "CompleteGame")
    Event.Bind(this, "CompleteRevealLampPuzzle")
end

function OnInteracted(character)
    if moving then
        return
    end

    if not openedOnce then
        openedOnce = true

        PlayOneShot(79, 1, 1)
        PlayOneShot(23, 0.5, 0.25)
    end

    moving = true
    object.RotateAround(object.position, object.upDirection, -180, 6)
    object.sound.Play()
    wait(6)
    moving = false
end

function CompleteSkulls()
    object.interactable.visible = false
end

function CompleteGame()
    object.interactable.visible = true
end

function CompleteRevealLampPuzzle()
    object.interactable.visible = false
end