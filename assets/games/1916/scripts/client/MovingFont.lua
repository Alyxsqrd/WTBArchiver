

function Begin()
    if isHost then
        while true do
            object.MoveTo(object.position + Vector3.New(0, -2, 0), 3)
            wait(1)
            object.MoveTo(object.position + Vector3.New(0, 2, 0), 3)
            wait(1)
        end
    end
end