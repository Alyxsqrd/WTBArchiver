

function Begin()
    if isHost then
        ChangeColorRandomly()
    end
end

function ChangeColorRandomly()
    while true do
        object.light.color = Random.Color()
        wait(Random.Number(0.5, 2))
    end
end