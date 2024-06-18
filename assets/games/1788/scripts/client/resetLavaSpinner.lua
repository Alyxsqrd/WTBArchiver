local speedOfSpinner = 2


function StartCollision(other)
    if (other.type == "Player") then
        if (other != LocalPlayer()) then
            -- If the player colliding is not our player, don't do anything
            return
        end

        print("Resetting to last checkpoint")
        
        -- Find the "Global Table" object and get the value "myLastCheckpoint" that we 
        -- have been updating as the player touches new checkpoints
        local checkpointPosition = PartByName("Global Table").table['myLastCheckpoint']
        if (checkpointPosition == nil) then
            -- If we don't have a checkpoint set yet, send the player to the position 0, 0, 0
            checkpointPosition = newVector3(0, 0, 0)
        end
        LocalPlayer().position = checkpointPosition
    end
end

function FixedUpdate()
    This.angles = This.angles + newVector3(0, speedOfSpinner, 0)
end