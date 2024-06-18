function StartCollision(other)
    if (other.type == "Player") then
        if (other != LocalPlayer()) then
            -- If the player colliding is not our player, don't do anything
            return
        end
    
    LocalPlayer().gravityMultiplier = 0.1
    LocalPlayer().gravityMultiplier = 3.0
    end
end