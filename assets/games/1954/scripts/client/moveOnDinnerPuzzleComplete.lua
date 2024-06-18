local moved = false


function Begin()
    Event.Bind(this, "DinnerPuzzleComplete")
end

function DinnerPuzzleComplete()
    if moved then
        return
    end
    moved = true

    object.MoveTo(object.position + Vector3.New(1, 0, 0), 3)
    wait(4)
    object.MoveTo(object.position + Vector3.New(0, 0, 4), 6)
end