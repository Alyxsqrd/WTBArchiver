function Begin()
    startPos = GetObjectByName("StartPos").position
    roundTimer = GetObjectByName("RoundTimer")
    respawnPos = GetObjectByName("Respawn").position
    controllerPos = GetObjectByName("ControllerPos").position
    playgroundPos = GetObjectByName("PlaygroundPos").position

    playersInGame = 0
    timeTillNextRound = 30
    isPlaying = false

    countingDown = true

    math.randomseed(os.time())

    Event.Bind(this, "KillCharacter")
    Event.Bind(this, "murder")

    roundTimer.worldText.text = "Not Enough Players"

    allChars = GetAllAliveCharacters()
    playerIndex = 1
    
    --countDown()
end

function Tick()
    if isPlaying then
        for i=1,#(allChars),1 do
            if (i == playerIndex) == false and allChars[i].alive then
                local disX = allChars[i].position.x - allChars[playerIndex].position.x
                local disY = allChars[i].position.y - allChars[playerIndex].position.y
                local disZ = allChars[i].position.z - allChars[playerIndex].position.z
                if disX < 1.2 and disX > -1.2 and disY < 1.2 and disY > -1.2 and disZ < 1.2 and disZ > -1.2  then
                   KillCharacter(allChars[i].netId)
                end
            end
        end
    end
end


function countDown()
    if isPlaying == false then
        roundTimer.worldText.text = "Next Round In: "..tostring(timeTillNextRound).."s"
    else
        roundTimer.worldText.text = "Round Ends In: "..tostring(timeTillNextRound).."s"
    end
    timeTillNextRound = timeTillNextRound - 1
    print(countingDown)
    if countingDown then
        if(timeTillNextRound <= 0) then
            countingDown = false
            wait(1)
            if isPlaying == false then
                startRound()
            else
                checkPlayers(true)
                print("Players Won")
            end
        else
            timer("countDown",1)
        end
    end
end

function startRound()
    allChars = GetAllAliveCharacters()
    playersInGame = #(allChars)
    if playersInGame > 1 then
        timeTillNextRound = 60
        playerIndex = math.ceil(math.random()*playersInGame)
        playersInGame = playersInGame - 1
        allChars[playerIndex].position = controllerPos
        allChars[playerIndex].forceField = true
        isPlaying = true
        for i=1,#(allChars),1 do
            if i == playerIndex == false then
                allChars[i].health = 1
            end
        end
        for i=1,#(allChars),1 do
            if i == playerIndex == false then
                allChars[i].position = startPos
            end
        end
        countingDown = true
        SendSystemChatToAll("The Tigger is "..allChars[playerIndex].username.."! Run Away!")
        countDown()
        print("Started Round")
    else
        timeTillNextRound = 30
    end
end

function endGame()
    returnToSpawn()
    allChars[playerIndex].forceField = false
    timeTillNextRound = 30
    isPlaying = false
    countingDown = false
    wait(3)
    countingDown = true
    countDown()
    print("Ended Game")
end
function returnToSpawn()
    local allChars = GetAllAliveCharacters()
    for i=1,#(allChars),1 do
        allChars[i].position = playgroundPos
        allChars[i].health = 100
    end
end

function OnPlayerJoin()
    if #GetAllPlayers() == 2 then
        countingDown = true
        countDown()
    end
end
function OnCharacterSpawn(character)
    character.speed = 2
    if not isPlaying then
        character.position = playgroundPos
    end
end

function OnPlayerLeave(player)
    if #GetAllPlayers() < 2 then
        countingDown = false
        wait(2)
        roundTimer.worldText.text = "Not Enough Players"
    end
    if player.character.health == 1 then
        playersInGame = playersInGame - 1
        checkPlayers(false)
        print("Player Left")
    end
end

function checkPlayers(left)
    if isPlaying then
        print(playersInGame)
        if left then
            if(playersInGame == 0) then
                SendSystemChatToAll("The Tigger Won!")
                endGame()
            else
                SendSystemChatToAll("The Players Won!")
                endGame()
            end
        else
            if(playersInGame == 0) then
                SendSystemChatToAll("The Tigger Won!")
                endGame()
            end
        end
    end
end

function murder(netID)
    GetCharacterByNetId(netID).Kill()
end

function KillCharacter(netID)
    local char = GetCharacterByNetId(netID)
    if(char.health == 1) then
        playersInGame = playersInGame - 1
    end
    char.Kill()
    checkPlayers(false)
    print("Player Killed")
end