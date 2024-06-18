local moved = false


function Begin()
    Event.Bind(this, "CompleteSkulls")
end

function CompleteSkulls()
    if moved then
        return
    end
    moved = true

    object.MoveTo(object.position + Vector3.New(0, 0, 2), 4)
    wait(4)
    object.MoveTo(object.position + Vector3.New(-8, 0, 0), 16)
end