function Tick()
    local chars = GetAllAliveCharacters()
    for _, char in pairs(chars) do
        if char.position.y < -20 and char.position.z < 25 then
            char.Kill()
        end
        if char.position.y < -20 and char.position.z > 25 then
            local newPos = Vector3.New(char.position.x, 101, 150)
            char.position = newPos
        end
    end
end