

function Begin()
    if isHost then
        while true do
            object.MoveTo(object.position + Vector3.New(-6, 0, 0), 3)
            wait(3.5)
            object.MoveTo(object.position + Vector3.New(6, 0, 0), 3)
            wait(3.5)
        end
    end
end