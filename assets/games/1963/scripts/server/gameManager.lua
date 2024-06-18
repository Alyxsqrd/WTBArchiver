function Begin()
    iceblock = GetObjectByName("Ice")

    startPos = GetObjectByName("StartPos").position
    roundTimer = GetObjectByName("RoundTimer")
    respawnPos = GetObjectByName("Respawn").position
    controllerPos = GetObjectByName("ControllerPos").position

    playersInGame = 0
    timeTillNextRound = 15
    isPlaying = false

    countingDown = true

    math.randomseed(os.time())

    rotAm = 0
    Event.Bind(this, "startRotate")
    Event.Bind(this, "endRotate")

    Event.Bind(this, "KillCharacter")
    Event.Bind(this, "murder")

    roundTimer.worldText.text = "Not Enough Players"

    rotate()
    --countDown()
end

function countDown()
    if isPlaying == false then
        roundTimer.worldText.text = "Next Round In: "..tostring(timeTillNextRound).."s"
    else
        roundTimer.worldText.text = "Round Ends In: "..tostring(timeTillNextRound).."s"
    end
    wait(1)
    timeTillNextRound = timeTillNextRound - 1
    if countingDown then
        if(timeTillNextRound <= 0) then
            if isPlaying == false then
                startRound()
            else
                checkPlayers(true)
            end
        else
            timer("countDown",0.2)
        end
    end
end

function startRound()
    local allChars = GetAllAliveCharacters()
    playersInGame = #(allChars)
    if playersInGame > 1 then
        local playerIndex = math.ceil(math.random()*playersInGame)
        playersInGame = playersInGame - 1
        allChars[playerIndex].position = controllerPos
        isPlaying = true
        iceblock.rotation = Vector3.New(90,0,0)
        rotAm = 0
        for i=1,#(allChars),1 do
            if i == playerIndex == false then
                allChars[i].health = 1
            end
        end
        wait(1)
        for i=1,#(allChars),1 do
            if i == playerIndex == false then
                allChars[i].position = startPos
            end
        end
        timeTillNextRound = 60
    end
    timeTillNextRound = 15
    countDown()
end

function endGame()
    returnToSpawn()
    rotAm = 0
    timeTillNextRound = 15
    isPlaying = false
    countingDown = false
    wait(3)
    countingDown = true
    countDown()
end
function returnToSpawn()
    local allChars = GetAllAliveCharacters()
    for i=1,#(allChars),1 do
        allChars[i].position = respawnPos
        allChars[i].health = 100
    end
end

function OnPlayerJoin()
    if #GetAllPlayers() == 2 then
        countingDown = true
        countDown()
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
    end
end

function checkPlayers(notleft)
    wait(1)
    if notleft then
        if(playersInGame == 0) then
            SendSystemChatToAll("The Controller Won!")
            endGame()
        else
            SendSystemChatToAll("The Players Won!")
            endGame()
        end
    else
        if(playersInGame == 0) then
            SendSystemChatToAll("The Controller Won!")
            endGame()
        end
    end
end

function startRotate(am)
    rotAm = am
end
function endRotate()
    rotAm = 0
end

function rotate()
    local tempRotation = iceblock.rotation.x + rotAm
    if tempRotation > 90 then
        tempRotation = iceblock.rotation.x+rotAm-90
    end
    if tempRotation < 0 then
        tempRotation = iceblock.rotation.x+rotAm+90
    end
    iceblock.rotation = Vector3.New(tempRotation,0,0)
    timer("rotate",0.01)
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
end