

function Begin()
    if isHost then
        while true do
            object.MoveTo(object.position + Vector3.New(0, 0, -12), 3)
            wait(6)
            object.MoveTo(object.position + Vector3.New(0, 0, 12), 3)
            wait(6)
        end
    end
end