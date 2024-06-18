function PhysicsTick()
    local vel = object.physics.velocity.Magnitude()

    if vel > 0.0 then
        --this.RunOnServer("SetColor", Color.green)
        object.blockRenderer.color = Color.green
    else
        --this.RunOnServer("SetColor", Color.grey)
        object.blockRenderer.color = Color.grey
    end
end

-- function SetColor(color)
--     object.blockRenderer.color = color
-- end

function Mag(vec3)
    return (vec3.x^2 + vec3.y^2 + vec3.z^2)^0.5
end