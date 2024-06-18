

function Begin()
    if isHost then
        Grow()
    end
end

function Grow()
    while true do
        wait(0.65)
        object.size = Vector3.New(1.45, 2.2, 1.2)
        wait(0.1)
        object.size = Vector3.New(1.3, 2.0, 1.2)
    end
end