function StartCollision(other)
    if IsHost and other.type == "Player" then
        other.position = newVector3(0, -250, 0)
    end
end