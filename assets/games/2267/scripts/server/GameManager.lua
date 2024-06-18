function Begin()
    floor = GetObjectByName("Floor")
    ceiling = GetObjectByName("Ceiling")
    block = GetObjectByName("Block")
    startPos = GetObjectByName("StartPos").position
    roundTimer = GetObjectByName("RoundTimer")
    winnerText = GetObjectByName("Winner")
    respawnPos = GetObjectByName("Respawn").position

    blockNo = 10
    blockMaxSize = 5
    blocksAtTop = true

    invincibilityTime = 5

    playersInGame = 0
    winner = ""
    timeTillNextRound = 30
    isPlaying = false

    normalGravity = Vector3.New(0,-1,0)
    leftPlayerName = ""

    math.randomseed(os.time())

    Event.Bind(this, "KillCharacter")
    Event.Bind(this, "murder")

    countDown()
end

function countDown()
    roundTimer.worldText.text = "Next Round In: "..tostring(timeTillNextRound).."s"
    wait(1)
    timeTillNextRound = timeTillNextRound - 1
    if(timeTillNextRound == 0) then
        startRound()
    else
        countDown()
    end
end

function startRound()
    blockNo = 10
    isPlaying = true
    invincibilityTime = 5
    blocksAtTop = false
    local allChars = GetAllAliveCharacters()
    playersInGame = #(allChars)
    if playersInGame > 0 then
        for i=1,#(allChars),1 do
            allChars[i].health = 1
        end
        wait(1)
        makeInvincible()
        wait(1)
        for i=1,#(allChars),1 do
            allChars[i].position = startPos
        end
        nextStage()
    else
        timeTillNextRound = 30
        countDown()
    end
end
function nextStage()
    blocksAtTop = not blocksAtTop
    spawnPlatforms(blocksAtTop)
    wait(invincibilityTime)
    if isPlaying then
        Flip()
    end
    wait(1)
    unMakeInvincible()
    wait(3)
    if isPlaying then
        makeInvincible()
    end
    wait(1)
    removePlatforms()
    if invincibilityTime > 0.5 then
        invincibilityTime = invincibilityTime - 0.2
    end
    blockNo = math.ceil(invincibilityTime)
    if isPlaying == true then
        nextStage()
    end
end

function spawnPlatforms(isTop)
    local sY = 0.5
    if isTop then
        sY = ceiling.position.y - 0.5
    end
    local floorSize = floor.size.x
    local hFloorSize = floorSize / 2
    for i=0,blockNo,1 do
        local tempBlock = DuplicateObject(block)
        tempBlock.position = Vector3.New(hFloorSize - math.random() * floorSize, sY, hFloorSize - math.random() * floorSize)
        tempBlock.size = Vector3.New(math.random()*blockMaxSize,1,math.random()*blockMaxSize)
        tempBlock.name = "tempBlock"
    end
end

function removePlatforms()
    local platforms = GetObjectsByName("tempBlock")
    for i=1,#(platforms),1 do
        DeleteObject(platforms[i])
    end
end

function makeInvincible()
    local allChars = GetAllAliveCharacters()
    for i=1,#(allChars),1 do
        if allChars[i].health == 1 then
            allChars[i].forceField = true
        end
    end
end
function unMakeInvincible()
    local allChars = GetAllAliveCharacters()
    for i=1,#(allChars),1 do
        if allChars[i].health == 1 then
            allChars[i].forceField = false
        end
    end
end

function Flip()
    local allChars = GetAllAliveCharacters()
    for i=1,#(allChars),1 do
        if allChars[i].health == 1 then
            allChars[i].gravityDirection = allChars[i].gravityDirection * -1
        end
    end
end

function endGame()
    returnToSpawn()
    timeTillNextRound = 30
    isPlaying = false
    if winner != "" then
        SendSystemChatToAll("Round Over! The Winner is "..winner.."!")
    end
    unMakeInvincible()
    removePlatforms()
    countDown()
end
function returnToSpawn()
    local allChars = GetAllAliveCharacters()
    for i=1,#(allChars),1 do
        if allChars[i].health == 1 then
            allChars[i].position = respawnPos
            allChars[i].gravityDirection = normalGravity
            allChars[i].health = 100
        end
    end
end

function OnPlayerLeave(player)
    if player.character.health == 1 then
        playersInGame = playersInGame - 1
        leftPlayerName = player.username
        checkPlayers()
    end
end

function KillCharacter(netID)
    local char = GetCharacterByNetId(netID)
    if(char.health == 1) then
        playersInGame = playersInGame - 1
    end
    char.Kill()
    checkPlayers()
end

function checkPlayers()
    wait(1)
    if(playersInGame == 1) then
        local allChars = GetAllAliveCharacters()
        for i=1,#(allChars),1 do
            if allChars[i].health == 1 then
                winner = allChars[i].username
                break
            end
        end
        winnerText.worldText.text = ("Winner: "..winner)
        endGame()
        return
    else
        if(playersInGame == 0) then
            winner = ""
            winnerText.worldText.text = ("Winner: None")
            endGame()
            return
        end
    end
end

function murder(netID)
    GetCharacterByNetId(netID).Kill()
end