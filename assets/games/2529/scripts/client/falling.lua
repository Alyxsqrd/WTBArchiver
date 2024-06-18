

local startPosition = object.position


function Begin()
    if isHost then
        while true do
            object.MoveTo(object.position + Vector3.New(0, -13, 0), 1)
            wait(1.5)

            object.MoveTo(object.position + Vector3.New(0, 13, 0), 3)
            wait(4)
        end
    end
end