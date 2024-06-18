local moved = false
local movedBack = false
local originalPosition


function Begin()
    originalPosition = object.position

    Event.Bind(this, "CompleteLampPuzzle")
    Event.Bind(this, "CloseBalcony")
end

function CompleteLampPuzzle()
    if moved then
        return
    end
    moved = true

    object.MoveTo(object.position + Vector3.New(-1, 0, 0), 3)
    wait(4)
    object.MoveTo(object.position + Vector3.New(0, 0, -4), 6)
end

function CloseBalcony()
    if movedBack then
        return
    end
    movedBack = true
    
    object.MoveTo(originalPosition, 1)
end