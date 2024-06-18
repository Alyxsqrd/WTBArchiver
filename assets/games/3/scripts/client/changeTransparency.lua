

function Begin()
    if IsHost then
        while (true) do
            for i=1,10 do
                object.renderer.transparency = object.renderer.transparency + 10
                wait(0.2)
            end
            wait(2)
            for i=1,10 do
                object.renderer.transparency = object.renderer.transparency - 10
                wait(0.2)
            end
            wait(2)
        end
    end
end