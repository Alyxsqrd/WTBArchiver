function Begin()
    if isHost then
        while true do
            object.blockRenderer.transparency = 100
            object.collider.enabled = false
            wait(6)
            object.blockRenderer.transparency = 0
            object.collider.enabled = true
            wait(42)
        end
    end
end