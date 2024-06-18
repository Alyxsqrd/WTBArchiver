local intermissionTimer = 30
local maximumGameTime = 120

local gameTime = 0


function Begin()
    if (isHost) then
        GameLoop()
    end
end

function GameLoop()
    while (true) do
        Intermission()
        WaitForEnd()
    end
end

function Intermission()
    SendSystemChatToAll("Intermission")
    for i = intermissionTimer, 0, -1 do
        TextOnScreen("Intermission.. "..i) 
        wait(1)
    end
end

function WaitForEnd()
    TextOnScreen("Begin!") 
    SendSystemChatToAll("Begin!")

    for i,v in ipairs(GetObjectsByName("Spleef")) do
        local spleefScript = v.GetScriptByName("spleef")
        if (IsValid(spleefScript) == false) then
            spleefScript = v.GetScriptByName("lavaSpleef")
        end
        if (IsValid(spleefScript)) then
            spleefScript.Run("Reset")
            waitTick(2)
        end
    end

    for i,v in ipairs(GetAllCharacters()) do
        if (IsValid(v)) then
            v.position = Vector3.New(Random.Number(-19, 19), 5, Random.Number(-19, 19))
        end
    end

    gameTime = 0
    local isSomeoneInPlay = true
    local numberInPlay = 0
    local lastFoundInPlay = nil
    while (isSomeoneInPlay) do
        wait(1)

        isSomeoneInPlay = false
        numberInPlay = 0
        lastFoundInPlay = nil
        for i,v in ipairs(GetAllCharacters()) do
            if (IsValid(v)) then
                if (v.position.y < 15 and v.alive) then
                    isSomeoneInPlay = true
                    numberInPlay = numberInPlay + 1
                    lastFoundInPlay = v.player
                end
            end
        end

        gameTime = gameTime + 1
        TextOnScreen(maximumGameTime - gameTime)

        if (gameTime >= maximumGameTime) then
            lastFoundInPlay = nil
            break
        end
        -- give gameTime some buffer for chars to teleport into the map
        -- and make sure we're playing with more than 1 person, otherwise let them run around freely by themselves
        if (numberInPlay <= 1 and gameTime > 5 and (#GetAllPlayers()) > 1) then
            break
        end 
    end

    if (IsValid(lastFoundInPlay)) then
        TextOnScreen("Winner: "..lastFoundInPlay.username)
        SendSystemChatToAll("Winner is "..lastFoundInPlay.username)
    else
        TextOnScreen("Draw! Time limit reached.") 
    end

    for i,v in ipairs(GetAllPlayers()) do
        if (IsValid(v)) then
            v.Respawn()
        end
    end

    wait(5)
end

function TextOnScreen(message)
    printScreen(message, 3)

    for i,v in ipairs(GetObjectsByName("Screen")) do
        if (IsValid(v.worldText)) then
            v.worldText.text = message
        end
    end 
end