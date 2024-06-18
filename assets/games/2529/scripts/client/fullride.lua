

function Begin()
    if isHost then
        while true do
            object.MoveTo(object.position + Vector3.New(0, 50, 0), 7)
            wait(14)
            object.MoveTo(object.position + Vector3.New(0, -50, 0), 7)
            wait(14)
        end
    end
end