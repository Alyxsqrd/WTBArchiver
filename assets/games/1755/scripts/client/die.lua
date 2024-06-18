function StartCollision(other)
    if (other.type == "Player") then
        if (other != LocalPlayer()) then
            -- If the player colliding is not our player, don't do anything
            return
        end
    
        LocalPlayer().position = newVector3(-100.9242, 15, 0);
    end
end