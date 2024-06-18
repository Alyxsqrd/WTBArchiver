function Begin()
    maxHealth = 3
    health = maxHealth
    if GetHostPlayer() == GetLocalPlayer() then
        object.renderer.color = Color.New( Random.Number(101, 121) / 255, 78 / 255, 55 / 255)
    end
end

function OnMouseClick()
    local sendtable = { GetLocalPlayer().netId, 1 , object.id , 1 }
    object.NetMessagePlayer(GetHostPlayer(), sendtable)
end

function blockDie(localplayerId)
    if object.name == "winner" then

        --change name, set vars
        object.name = "DigBlockTemp"
        playname = GetPlayerByNetId(localplayerId).nickname
        
        --rewards player 25 points
        newTable = {1, localplayerId, 2, 25}
        GetObjectByName("leaderboardManager").NetMessagePlayer(GetHostPlayer(), newTable)

        --creates trophy where block was
        trophy = GetObjectByName("Trophy").Duplicate()
        trophy.position = object.position

        --returns block to inactive state
        object.position = Vector3.New(31,10000,-1)
        health = maxHealth
        object.renderer.transparency = (1 - (health / maxHealth)) * 100


        --probably gives them 1 trophy
        local newTable = {1, localplayerId, 1, 1}
        GetObjectByName("leaderboardManager").NetMessagePlayer(GetHostPlayer(), newTable)

        wait(0.25)

        --announce that a treasure was found
        if #GetObjectsByName("winner") > 0 then
            SendSystemChatToAll("A treasure has been found by "..playname.. "!   "..#GetObjectsByName("winner").."/3 Remain." )
            
        else

            SendSystemChatToAll("The last treasure has been found by "..playname.. "!")

            --end gane
            local sendtable = {localplayerId, 1}
            GetObjectByName("gameManager").NetMessagePlayer(GetHostPlayer(), sendtable)
        end

        
        --delete trophy
        wait(5)
        trophy.Delete()
        
        
    else
        --print(localplayerId)
        --give player 1 point since they didn't find anything
        newTable = {1, localplayerId, 2, 1}
        GetObjectByName("leaderboardManager").NetMessagePlayer(GetHostPlayer(), newTable)
    end
    
    

    --object.Delete()
    --resets block to inactive state
    object.name = "DigBlockTemp"
    object.position = Vector3.New(31,10000,-1)
    health = maxHealth
    object.renderer.transparency = (1 - (health / maxHealth)) * 100

end

function OnNetMessage(thetable)
    --local sendtable = { GetLocalPlayer().netId, 1 , object.id , 1 }
    if object.id == thetable[3] then
        if thetable[2] == 1 then
            object.sound.Play()
            health = health - 1
            object.renderer.transparency = (1 - (health / maxHealth)) * 100
            if health <= 0 then
                blockDie(thetable[1])
            end
        end
    end
end