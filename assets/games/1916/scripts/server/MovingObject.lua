

function Begin()
    if isHost then
        while true do
            object.MoveTo(object.position + Vector3.New(0, 0, -12), 3)
            wait(6)
            object.MoveTo(object.position + Vector3.New(0, 0, 12), 3)
            wait(6)
            object.RotateAround(Vector3.New(250, 25, 250), Vector3.New(250, 25, 250), 1.0, 1.0)
        end
    end
end