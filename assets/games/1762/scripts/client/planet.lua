

function ContinueCollision(other)
    if (other.type == "Player" and other.isLocal) then
        local directionTowardsPlanet = This.position - other.position
        other.gravityDirection = directionTowardsPlanet
    end
end

function StartCollision(other)
    if (other.type == "Player" and other.isLocal) then
        other.SetMovementMode("Normal")
    end
end

function EndCollision(other)
    if (other.type == "Player" and other.isLocal) then
        other.SetMovementMode("NoClip")
    end
end