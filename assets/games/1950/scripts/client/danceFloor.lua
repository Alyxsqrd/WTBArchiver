

function Begin()
    if isHost then
        object.localTable["synced"] = Random.Number(0, 2) > 1
        ChangeColorRandomly()
    end
end

function ChangeColorRandomly()
    while true do
        object.renderer.color = Random.Color()
        if object.localTable["synced"] then
            wait(0.75)
        else
            wait(Random.Number(0.25, 2.5))
        end
    end
end