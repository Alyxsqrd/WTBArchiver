function StartCollision (_other)
    if (_other.type == "Player") then
        _other.speed = 9;
    end
end