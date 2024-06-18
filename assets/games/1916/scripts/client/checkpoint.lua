


function StartCollision(other)
    if (other.type == "Player") then
        if (other != LocalPlayer()) then
            -- If the player colliding is not our player, don't do anything
            return
        end

        print("You've REACHED your next destination!")

        -- Set all other checkpoints to the color red
        for i,v in ipairs(PartsByName("Checkpoint")) do
            v.color = newColor(1, 0, 0, 0.5)
        end
        -- Set this checkpoint to the color green
        This.color = newColor(0, 1, 0, 0.5)
        
        -- Find the object "Global Table" and set a value called "myLastCheckpoint" to the
        -- position of this checkpoint. We can use this when we fall on the obby to 
        -- teleport back here
        PartByName("Global Table").table['myLastCheckpoint'] = This.position
    end
end