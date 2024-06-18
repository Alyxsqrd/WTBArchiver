--// Variables. 
local loopStarted = false
local gameStarted = false
local gameList = {"Guess the Color!"}
local gameSelected = nil
local alivePlayers = {}

-- Minigame specific variables. 
    -- "Guess the Color!"
    local colorSetup = false
    local hexColors = {"#ff0000", "#ff6a00", "#ffd500", "#0dff00", "#00fff2", "#0040ff", "#ab00d6", "#ffffff", "#000000"}
    local colorParts = {GetObjectById(95), GetObjectById(97), GetObjectById(99), GetObjectById(93), GetObjectById(91), GetObjectById(101), GetObjectById(103), GetObjectById(105), GetObjectById(107), GetObjectById(109), GetObjectById(111), GetObjectById(113), GetObjectById(115)}
    local selectedColor = nil
    local speedMultiplier = 1

    -- "Flood escape!"
    local floodSetup = false
    local floodParts = {GetObjectById(119), GetObjectById(121), GetObjectById(123), GetObjectById(125), GetObjectById(127), GetObjectById(129), GetObjectById(131), GetObjectById(133), GetObjectById(135), GetObjectById(137), GetObjectById(139)}
    local floodKillBlock, floodStartBlock = floodParts[2], floodParts[11]

--// Functions.
local function checkPlrAmount()
    -- Function checks how many players are in the game, and waits for 2 players.
    local plrs = GetAllPlayers()
    if #plrs < 2 then 
        if gameStarted == false then 
            SendSystemChatToAll("Minigames requires 2 players to start! Checking again in ten seconds!")
            return false
        elseif gameStarted == true then 
            SendSystemChatToAll("Minigames didn't detect 2 players or more, stopping game!")
            return false
        end
    elseif #plrs >= 2 then 
        return true
    end
end
local function waitPlrsLoaded()
    -- Function makes sure all characters are loaded in the game so everyone gets teleported properly.
    local plrs = GetAllPlayers()
    for i = 1, #plrs do 
        repeat
            wait(1)
        until plrs[i].character ~= nil
    end
end
local function teleportPlayers(desiredLocation)
    -- Function that teleports all players to the desired location.
    local plrs = GetAllPlayers()
    for i = 1, #plrs do 
        if plrs[i].character ~= nil then 
            plrs[i].character.position = desiredLocation
        end
    end
end

local function createPart(partLocation, partColor, partSize, wantCollide, wantReturn)
    local newPart = CreateEmptyObject()
    wait(0.3)
    newPart.AddComponent("renderer")
    newPart.size = partSize
    local partRenderer = newPart.renderer
    partRenderer.color = Color.ColorFromHex(partColor)
    if wantCollide == true then 
        newPart.AddComponent("collider")
    end
    newPart.position = partLocation
    if wantReturn == true then 
        return newPart
    end
end
local function changeTransparency(isATable, part, exceptionPart, transparencyAmount)
    if isATable == true then 
        for i = 1, #part do 
            if exceptionPart ~= nil then
                if part[i] ~= exceptionPart then
                    local partRenderer = part[i].renderer 
                    partRenderer.transparency = transparencyAmount
                end
            elseif exceptionPart == nil then 
                local partRenderer = part[i].renderer 
                partRenderer.transparency = transparencyAmount
            end
        end
    elseif isATable == false then 
        local partRenderer = part.renderer 
        partRenderer.transparency = transparencyAmount
    end
end
local function changeCollide(isATable, part, exceptionPart, collideable)
    if isATable == true then 
        for i = 1, #part do 
            if exceptionPart ~= nil then
                if part[i] ~= exceptionPart then
                    local partCollider = part[i].collider
                    partCollider.enabled = collideable
                end
            elseif exceptionPart == nil then 
                local partCollider = part[i].collider
                partCollider.enabled = collideable
            end
        end
    elseif isATable == false then 
        local partCollider = part.collider
        partCollider.enabled = collideable
    end
end

local function cleanupGame()
    gameSelected = nil
    gameStarted = false
    colorSetup = false
    speedMultiplier = 1
    alivePlayers = {}
    teleportPlayers(Vector3.new(0, 13, 0))
    changeTransparency(true, colorParts, nil, 100)
    changeCollide(true, colorParts, nil, false)
    wait(3)
end

local function gameLoop()
    while true do 
        if gameStarted == false then 
            -- If we don't have enough players to start the game, we wait until we do.
            if checkPlrAmount() == false then 
                repeat
                    wait(10)
                until checkPlrAmount() == true
            -- Once we have enough players to start the game, we will select a minigame to play.
            elseif checkPlrAmount() == true then 
                -- Selecting a random gamemode from the list.
                local randomSelection = math.random(1, #gameList)
                gameSelected = gameList[randomSelection]
                SendSystemChatToAll(gameSelected .. " - minigame was chosen!")
                gameStarted = true
            end
            wait(1)
        elseif gameStarted == true then 
            -- Making sure we still have two players to start the minigames.
            if checkPlrAmount() == true then 
                -- We need to make sure all players are loaded, so we have enough to actually play the minigame. 
                waitPlrsLoaded()
                if gameSelected ~= nil then
                    if gameSelected == "Guess the Color!" then 
                        -- Checking to see if we have setup this minigame.
                        if colorSetup == false then
                            colorSetup = true

                            changeTransparency(true, colorParts, nil, 0)
                            changeCollide(true, colorParts, nil, true)

                            SendSystemChatToAll("Starting minigame; " .. gameSelected .. " in three seconds!")
                            wait(3)

                            local plrs = GetAllPlayers()
                            for i = 1, #plrs do 
                                table.insert(alivePlayers, plrs[i].username)
                            end
                            teleportPlayers(Vector3.new(0, 3, 0))
                        end

                        -- Loop function for the individual rounds of guess the color. 
                        local function colorGameLoop()
                            if colorSetup == true then 
                                if #alivePlayers >= 2 then 
                                    local randomSelection = math.random(1, #colorParts)
                                    local selectedPart = colorParts[randomSelection]
                                    
                                    changeTransparency(true, colorParts, selectedPart, 50)
                                    SendSystemChatToAll("A color has been chosen, stand on the right one to live! You have " .. speedMultiplier * 10 .. " seconds.")
                                    wait(speedMultiplier * 5)
                                    changeTransparency(true, colorParts, selectedPart, 100)
                                    changeCollide(true, colorParts, selectedPart, false)
                                    wait(3)
                                    changeTransparency(true, colorParts, selectedPart, 0)
                                    changeCollide(true, colorParts, selectedPart, true)
                                    if speedMultiplier > 0.2 then 
                                        speedMultiplier = speedMultiplier - 0.2
                                    end
                                elseif #alivePlayers == 1 then 
                                    SendSystemChatToAll(alivePlayers[1] .. " has won this minigame! Selecting the next minigame.")
                                    cleanupGame()
                                else
                                    SendSystemChatToAll("A draw! Selecting the next minigame.")
                                    cleanupGame()
                                end
                            end
                        end
                        colorGameLoop()
                    elseif gameSelected == "Flood" then 
                        if floodSetup == false then 
                            floodSetup = true
                            
                            changeTransparency(true, floodParts, nil, 0)
                            changeCollide(true, floodParts, nil, true)

                            
                            SendSystemChatToAll("Starting minigame; " .. gameSelected .. " in three seconds!")
                            wait(3)

                            local plrs = GetAllPlayers()
                            for i = 1, #plrs do 
                                table.insert(alivePlayers, plrs[i].username)
                            end
                            teleportPlayers(Vector3.new(0, 3, 0))
                        end

                        local function floodLoop()
                            
                        end 
                        floodLoop()
                    end
                end
            elseif checkPlrAmount() == false then 
                -- Something happened and we don't have enough people to start/continue the game.
                cleanupGame()
            end
            wait(1)
        end
    end
end

--// Connectors.
function OnCharacterSpawn(character)
    for i,v in pairs(alivePlayers) do 
        if v == character.username then 
            table.remove(alivePlayers, i)
        end
    end
end

function OnPlayerJoin(player)
    if loopStarted == false then
        loopStarted = true
        gameLoop()
    end
end