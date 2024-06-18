function Begin()
    gameInProgress = false
    print("Loading..")
    wait(5)
    Start()
end

function Start()
    
    SetupGame()
    wait(3)
    map = "medium"
    SendSystemChatToAll("Performing clean up before beginning round... 15s")
    gameInProgress = false
    CleanUp()
    wait(5)
    SendSystemChatToAll("Spawning Map... ~20s")
    SpawnMap()
    SendSystemChatToAll("Spawning Players...")
    wait(5)
    gameInProgress = true
    SpawnPlayers()
end

function SetupGame()
    local desiredAmount = 300
    local digBlock = GetObjectByName("DigBlockTemp")
    local digBlockCount = GetObjectsByName("DigBlockTemp")

    while #digBlockCount != desiredAmount do
        wait(0.01)
        if #digBlockCount > desiredAmount then
            digBlockCount[#digBlockCount].Delete()
            
            digBlockCount = GetObjectsByName("DigBlockTemp")
        elseif #digBlockCount < desiredAmount then
            local clone = digBlockCount[#digBlockCount].Duplicate()
            clone.position = Vector3.New(31,10000,-1)
            
            digBlockCount = GetObjectsByName("DigBlockTemp")
        end
    end
end

function CleanUp()

    playerz = GetAllAliveCharacters()
    for i = 1,#playerz do
        playerz[i].position = Vector3.New(0,37,0)
        wait(.5)
    end


    cleanparts = GetObjectsByName("DigBlock")
    if #cleanparts == 0 then

    else
        for i = 1,#cleanparts do
            wait(0.01)
            cleanparts[i].name = "DigBlockTemp"
            cleanparts[i].position = Vector3.New(31,10000,-1)
            cleanparts[i].renderer.transparency = 0
        end
    end
end

function SpawnMap()
    if map == "large" then
        for i = 1,11 do
            for j = 1,11 do
                for k = 1,7 do
                    if #GetObjectsByName("DigBlockTemp") > 0 then
                        block = GetObjectByName("DigBlockTemp")
                        block.name = "DigBlock"
                        block.position = Vector3.New((-6 + i)*4, 4*(0 - k), (-6 + j)*4)
                        wait(0.01)
                    else
                        SendSystemChatToAll("NOT ENOUGH BLOCKS")
                    end
                end
            end
        end
    end

    if map == "medium" then
        for i = 1,7 do
            for j = 1,7 do
                for k = 1,5 do
                    if #GetObjectsByName("DigBlockTemp") > 0 then
                        block = GetObjectByName("DigBlockTemp")
                        block.name = "DigBlock"
                        block.position = Vector3.New((-4 + i)*4, 4*(0 - k), (-4 + j)*4)
                        wait(0.01)
                    else
                        SendSystemChatToAll("NOT ENOUGH BLOCKS")
                    end
                end
            end
        end
    end

    if map == "small" then
        for i = 1,3 do
            for j = 1,3 do
                for k = 1,3 do
                    if #GetObjectsByName("DigBlockTemp") > 0 then
                        block = GetObjectByName("DigBlockTemp")
                        block.name = "DigBlock"
                        block.position = Vector3.New((-2 + i)*4, 4*(0 - k), (-2 + j)*4)
                        wait(0.01)
                    else
                        SendSystemChatToAll("NOT ENOUGH BLOCKS")
                    end
                end
            end
        end
    end

    for i = 1,3 do
        objectz = GetObjectsByName("DigBlock")
        num = Random.NumberRounded(0,#objectz)
        --num = i
        objectz[num].name = "winner"
    end
    --num = 1
    

end

function SpawnPlayers()
    playerz = GetAllAliveCharacters()
    for i = 1,#playerz do
        playerz[i].position = Vector3.New(0,1,0)
        wait(.5)
    end
end

function OnNetMessage(thetable)
    if thetable[2] == 1 then
        wait(10)
        GetObjectByName("leaderboardManager").GetScriptByName("leaderBoardManager").Run("updateDisplay")
        Start()
    end
end

function OnPlayerJoin(playa)
    playa.SendSystemChat("Welcome to The Dig!  The game will start momentarily...")
    playa.SendSystemChat("Instructions: Click blocks to dig them up, find treasure to score bonus points!")
    if gameInProgress == true then
        playa.SendSystemChat("You have joined a game in progress.")
        wait(2) 
        repeat wait(.1) until(IsValid(playa.character))
        GetCharacterFromPlayer(playa).position = Vector3.New(0,1,0)
    end
end