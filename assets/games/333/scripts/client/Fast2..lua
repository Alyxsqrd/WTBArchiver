function StartCollision (_other)
    if (_other.type == "Player") then
        _other.speed = 110;
    end
end