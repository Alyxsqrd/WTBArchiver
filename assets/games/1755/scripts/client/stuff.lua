madblock = PartByName("Mad Block")

function StartCollision(other)
    if (other.type == "Player") then
        if (other != LocalPlayer()) then
            -- If the player colliding is not our player, don't do anything
            return
        end

        print("Block is mad >:(")
        
        CreateTalkBubble(madblock, "Why'd You Step On Me >:(")

Explode(madblock.position, 7, 10, true, false)

LocalPlayer().position = newVector3(0,5,0)

        end
    end