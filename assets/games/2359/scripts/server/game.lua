intermissionTime = 10
roundBeginTime = 5
roundEndTime = 10
disaster_table = {"Flood", "Man Eating Cube", "Asteroid Storm", "Four Corners", "Hole In The Wall", "Alien Abduction", "Spin Zone"}
currentDisaster = "NONE"
roundcounter = 0

rotation = 3

--MODIFIERS?
--Low Gravity  
--High Gravity
--Slow Speed
--Fast Speed

--large meteors
--lots of small meteors


roundTimeRemaining = 0

function Begin()
    SendSystemChatToAll('Starting Game...')
    wait(5)

    while true do
        roundcounter = roundcounter+1
        --change map every 5 rounds?

        currentDisaster = Intermission()

        if currentDisaster == "Four Corners" then
            SpawnPlayers(GetObjectByName("FourSquareSpawn").position)
        elseif currentDisaster == "Spin Zone" then
            SpawnPlayers(GetObjectByName("SpinnerSpawners"))
        else
            SpawnPlayers()
        end

        disOverride = 'none'

        if disOverride == 'none' then
            if currentDisaster == 'Flood' then
                SendSystemChatToAll('Rules: Avoid the flood as it rises')
                WaterFlood()
            elseif currentDisaster == 'Man Eating Cube' then
                SendSystemChatToAll('Rules: Avoid the Spirit as it hunts down players.')
                Cube()
                --SendSystemChatToAll('MAN EATING CUBE DISABLED CURRENTLY')
            elseif currentDisaster == 'Asteroid Storm' then
                SendSystemChatToAll('Rules: Avoid the falling asteroids as they rain from the sky.')
                --SendSystemChatToAll('ASTEROID STORM DISABLED CURRENTLY')
                Meteors()
            elseif currentDisaster == "Four Corners" then
                SendSystemChatToAll('Rules: Stand on the quadrent that is visible to avoid elimination.')
                FourCorners()
            elseif currentDisaster == "Hole In The Wall" then
                SendSystemChatToAll('Rules: Stand in the gaps of the walls to avoid being hit.')
                HoleInWall()
            elseif currentDisaster == "Alien Abduction" then
                SendSystemChatToAll("Rules: Avoid the UFO beam as it tries to abducts players.")
                UFOAttack()
            elseif currentDisaster == "Spin Zone" then
                SendSystemChatToAll("Rules: Avoid the large beams as they both rotate around.")
                SpinZone()
            end
        else
            if disOverride == 'Flood' then
                SendSystemChatToAll('OVERRIDE Flood')
                WaterFlood()
            elseif disOverride == 'Man Eating Cube' then
                SendSystemChatToAll('OVERRIDE Man Eating Cube')
                Cube()
            elseif disOverride == 'Asteroid Storm' then
                SendSystemChatToAll('OVERRIDE Asteroid Storm')
                Meteors()
            elseif disOverride =='Four Corners' then
                SendSystemChatToAll('OVERRIDE Four Corners')
                FourCorners()
            elseif disOverride == 'Hole In The Wall' then
                SendSystemChatToAll('OVERRIDE Hole In The Wall')
                HoleInWall()
            elseif disOverride == "Alien Abduction" then
                SendSystemChatToAll("OVERRIDE Alien Abduction")
                UFOAttack()
            elseif disOverride == "Spin Zone" then
                SendSystemChatToAll("OVERRIDE Spin Zone")
            end
        end

        AnnounceWinners()

        ReturnPlayers()
    end
end

---------------
-- Player/Interround functions
---------------

function anyPlayersAlive()
    players = GetAllPlayers()
    anyAlive = false
    for iCounter = 1,#players do 
        if IsValid(object.localTable[players[iCounter].netId.."alive"]) then
            if object.localTable[players[iCounter].netId .."alive"] == true then
                anyAlive = true
            end
        end
    end
    if anyAlive == false then
        roundTimeRemaining = roundEndTime
        SendSystemChatToAll("No Players Remaining")
        return false
    else
        return true
    end
end

function AnnounceWinners()
    players = GetAllPlayers()
    counter = 1
    survivorList = {}

    for i = 1,#players do
        if IsValid(object.localTable[players[i].netId.."alive"]) then
            if object.localTable[players[i].netId.."alive"] == true then
                survivorList[counter] = players[i].nickname
                object.localTable[players[i].netId .."wins"] = (object.localTable[players[i].netId .."wins"] + 1)
                counter = counter+1
            end
        end
    end

    strn = ""
    if #survivorList > 0 then
        for k = 1,#survivorList do
            strn = strn .. survivorList[k]
            if k < #survivorList then
                strn = strn .. ", "
            elseif k == #survivorList then
                strn = strn .. "!"
            end
        end
    end
    SendSystemChatToAll("Round " .. roundcounter .. " Survivors: "..strn)
    updateBoard()
end

function updateBoard()
    players = GetAllPlayers()

    firstplace = ""
    firstplaceValue = -1
    firstplaceId = 1000000
    for i = 1,#players do
        if object.localTable[players[i].netId .. "wins"] >= firstplaceValue then
            if object.localTable[players[i].netId .. "wins"] > firstplaceValue then
                firstplace = players[i].nickname
                firstplaceValue = object.localTable[players[i].netId .. "wins"]
                firstplaceId = players[i].netId
            elseif object.localTable[players[i].netId .. "wins"] == firstplaceValue then
                if players[i].netId < firstplaceId then
                    firstplace = players[i].nickname
                    firstplaceValue = object.localTable[players[i].netId .. "wins"]
                    firstplaceId = players[i].netId
                end
            end
        end
    end
    secondplace = ""
    secondplaceValue = -1
    secondplaceId = 1000000
    for i = 1,#players do
        if players[i].netId ~= firstplaceId then
            if object.localTable[players[i].netId .. "wins"] >= secondplaceValue then
                if object.localTable[players[i].netId .. "wins"] > secondplaceValue then
                    secondplace = players[i].nickname
                    secondplaceValue = object.localTable[players[i].netId .. "wins"]
                    secondplaceId = players[i].netId
                elseif object.localTable[players[i].netId .. "wins"] == secondplaceValue then
                    if players[i].netId < secondplaceId then
                        secondplace = players[i].nickname
                        secondplaceValue = object.localTable[players[i].netId .. "wins"]
                        secondplaceId = players[i].netId
                    end
                end
            end
        end
    end
    thirdplace = ""
    thirdplaceValue = -1
    thirdplaceId = 1000000
    for i = 1,#players do
        if players[i].netId ~= firstplaceId and players[i].netId ~= secondplaceId then
            if object.localTable[players[i].netId .. "wins"] >= thirdplaceValue then
                if object.localTable[players[i].netId .. "wins"] > thirdplaceValue then
                    thirdplace = players[i].nickname
                    thirdplaceValue = object.localTable[players[i].netId .. "wins"]
                    thirdplaceId = players[i].netId
                elseif object.localTable[players[i].netId .. "wins"] == thirdplaceValue then
                    if players[i].netId < thirdplaceId then
                        thirdplace = players[i].nickname
                        thirdplaceValue = object.localTable[players[i].netId .. "wins"]
                        thirdplaceId = players[i].netId
                    end
                end
            end
        end
    end

    GetObjectByName("Leaderboard_FirstPlaceName").worldText.text = firstplace
    GetObjectByName("Leaderboard_SecondPlaceName").worldText.text = secondplace
    GetObjectByName("Leaderboard_ThirdPlaceName").worldText.text = thirdplace
    GetObjectByName("Leaderboard_FirstPlaceValue").worldText.text = firstplaceValue
    GetObjectByName("Leaderboard_SecondPlaceValue").worldText.text = secondplaceValue
    GetObjectByName("Leaderboard_ThirdPlaceValue").worldText.text = thirdplaceValue
end

function updateRoundTimer(timeRemaining)
    GetObjectByName("Leaderboard_RoundTimer").worldText.text = math.floor(timeRemaining)
end

function Intermission()
    SendSystemChatToAll("Intermission...")

    roundTimeRemaining = intermissionTime
    GetObjectByName("Leaderboard_RoundName").worldText.text = "Intermission"
    for i = 1,intermissionTime do
        wait(1)
        roundTimeRemaining = roundTimeRemaining-1
        updateRoundTimer(roundTimeRemaining)
    end

    --result = disaster_table[math.floor(Random.Number(.5, (#disaster_table+0.5))+0.5)]
    result = disaster_table[rotation]
    if rotation == 7 then
        rotation = 1
    else
        rotation = rotation + 1
    end

    resulttext = tostring(result)
    
    if tostring(result) == "Man Eating Cube" then
        resulttext = "The Spirit"
    end

    SendSystemChatToAll("Round " .. roundcounter .. " Disaster : " .. tostring(resulttext)) 
    GetObjectByName("Leaderboard_RoundName").worldText.text = tostring(resulttext)

    return result
end

function SpawnPlayers(vector)
    players = GetAllPlayers()
    for i = 1,#players do
        if players[i].hasAliveCharacter then
            object.localTable[players[i].netId .. "alive"] = true
        end
    end

    if IsObject(vector) then
        spawns = vector.GetAllChildren()
    end
    for i = 1,#players do
        if IsValid(vector) then
            if players[i].hasAliveCharacter then
                if IsObject(vector) then
                    players[i].character.position = spawns[i].position
                else
                    players[i].character.position = vector
                end
            end
        else
            if players[i].hasAliveCharacter then
                players[i].character.position = Vector3.New(0.0, 20.0, 0.0)
            end
        end
        wait(.5)
    end
end

function ReturnPlayers()
    players = GetAllPlayers()

    for i = 1,#players do
        if players[i].hasAliveCharacter then
            players[i].character.position = GetObjectByName("Respawn").position
        end
        wait(.5)
    end
end

---------------
-- Disasters
---------------

function Meteors()

    duration = 45
    roundTimeRemaining = duration + roundBeginTime + roundEndTime

    frequency = 3 -- seconds between spawns
    spawns = 3 --number per spawn
    targetedspawns = 1 --asteroids with player proximity
    speed = 30 --units per second
    resolution = 30
    playerz = GetAllPlayers()
    spawnadd = #playerz * targetedspawns
    for i = 1,roundBeginTime do
        wait(1)
        roundTimeRemaining = roundTimeRemaining- 1
        updateRoundTimer(roundTimeRemaining)
    end

    for i = 1,duration/frequency do
        if not anyPlayersAlive() then
            break
        end
        meteor = GetObjectsByName("Meteors")
        for j = 1,spawns+ (#playerz) do
            if j <= spawns then
                meteor[j].renderer.visible = true
                meteor[j].position = Vector3.New(Random.Number(-45,45),45,Random.Number(-45,45))
                meteor[j].rotation = Vector3.New(Random.Number(-360,360),Random.Number(-360,360),Random.Number(-360,360))
            elseif j > spawns then
                if playerz[j-spawns].hasAliveCharacter then
                    if IsValid(object.localTable[playerz[j - spawns].netId .. "alive"]) then
                        if object.localTable[playerz[j - spawns].netId .. "alive"] == true then
                            meteor[j].renderer.visible = true
                            meteor[j].position = Vector3.New(playerz[j-spawns].character.position.x, 45, playerz[j-spawns].character.position.z) + Vector3.New(Random.Number(-12,12),0,Random.Number(-12,12))
                            meteor[j].rotation = Vector3.New(Random.Number(-360,360),Random.Number(-360,360),Random.Number(-360,360))
                        end
                    end
                end
            end
        end

        addx = {Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5)}
        addz = {Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5)}
        addy = {Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5), Random.Number(-5,5)}


        for k = 1,resolution*frequency do
            wait(1/resolution)
            roundTimeRemaining = roundTimeRemaining - 1/resolution
            updateRoundTimer(roundTimeRemaining)
            for met = 1,spawns+(spawnadd) do
                meteor[met].position = meteor[met].position + Vector3.New(addx[met]/resolution,-speed/resolution,addz[met]/resolution)
                meteor[met].rotation = meteor[met].rotation + Vector3.New(addx[met],0,addz[met])
            end
        end

        for j = 1,spawns+ (#playerz) do

            meteor[j].renderer.visible = false
            meteor[j].position = Vector3.New(200,40,0)
            meteor[j].rotation = Vector3.New(0,0,0)
        end
    end
    --wait(roundEndTime)
    for i = 1,roundEndTime do
        wait(1)
        roundTimeRemaining = roundTimeRemaining- 1
        updateRoundTimer(roundTimeRemaining)
    end
end

function Cube()
    --man Eating Cube
    duration = 40
    roundTimeRemaining = duration + roundBeginTime + roundEndTime

    cube = GetObjectByName('ManEatingCube')
    cube.renderer.visible = true
    cube.collider.enabled = true
    speed = 7
    growth = 1
    interval = 10
    resolution = 60
    mode = 2
    for i = 1,roundBeginTime do
        wait(1)
        roundTimeRemaining = roundTimeRemaining- 1
        updateRoundTimer(roundTimeRemaining)
    end

    for i = 1,(duration/interval) do
        if not anyPlayersAlive() then
            break
        end
        if mode == 1 then
            mode = 2
        elseif mode == 2 then
            mode = 1
        end

        players = GetAllPlayers()
        anyAlive = false
        for iCounter = 1,#players do 
            if IsValid(object.localTable[players[iCounter].netId.."alive"]) then
                if object.localTable[players[iCounter].netId .."alive"] == true then
                    anyAlive = true
                end
            end
        end
        if anyAlive == false then
            roundTimeRemaining = roundEndTime
            SendSystemChatToAll("No Players Remaining")
            break
        end

        --every second for INTERVAL before changing speed
        for k = 1, interval do
            
            players = GetAllPlayers()
            target = 'none'
            dis = 1000
            --find new target for next second
            
            for pla = 1,#players do
                if players[pla].hasAliveCharacter then
                    -- FOR EVERY CHARACTER
                    if IsValid(object.localTable[players[pla].netId.."alive"]) then
                        -- IF CHARACTER HAS AN 'ALIVE' VARIABLE
                        if object.localTable[players[pla].netId.."alive"] == true then
                            --IF CHARACTER ALIVE VARIABLE IS SET TO TRUE
                            
                            if Vector3.Distance(players[pla].character.position , cube.position) < dis then
                                -- IF CHARACTER IS CLOSE THAN OTHERS
                                dis = Vector3.Distance(players[pla].character.position , cube.position)
                                target = players[pla].character
                            end

                        end

                    end

                end

            end
            
            -- ATTEMPT TO TAKE STEPS TOWARDS TARGET FOR NEXT SECOND
            for j = 1,resolution do
                wait(1/resolution)
                roundTimeRemaining = roundTimeRemaining - 1/resolution
                updateRoundTimer(roundTimeRemaining)

                --IF VALID TARGET
                if target ~= 'none' then
                    unit = Vector3.Normalize(target.position - cube.position)
                    cube.position = (cube.position + unit*speed/resolution*mode)
                    cube.rotation = Vector3.LookRotation(target.position-cube.position, Vector3.New(0,1,0))
                end

            end
            
        end

    end

    for i = 1,roundEndTime do
        wait(1)
        roundTimeRemaining = roundTimeRemaining- 1
        updateRoundTimer(roundTimeRemaining)
    end

    cube.position = Vector3.New(0,4,-25)
    cube.renderer.visible = false
    cube.collider.enabled = false
end

function WaterFlood()
    duration = 30
    endpause = 5
    roundTimeRemaining = duration + roundBeginTime + roundEndTime
    resolution = 60 -- updates per second
    speed = 0.4 * 60 / duration --units per second
    for i = 1,roundBeginTime do
        wait(1)
        roundTimeRemaining = roundTimeRemaining- 1
        updateRoundTimer(roundTimeRemaining)
    end
    lava1 = GetObjectByName('Lava1')
    lava2 = GetObjectByName('Lava2')
    lava1.renderer.visible = true
    lava2.renderer.visible = true

    for i = 1,((duration-endpause)*resolution) do
        if not anyPlayersAlive() then
            break
        end
        wait(1/resolution)
        roundTimeRemaining = roundTimeRemaining - 1/resolution
        updateRoundTimer(roundTimeRemaining)
        lava1.position = lava1.position + Vector3.New(0,speed/resolution, 0)
        lava2.position = lava2.position + Vector3.New(0,speed/resolution, 0)
    end

    for i = 1,resolution*endpause do
        wait(1/resolution)
        roundTimeRemaining = roundTimeRemaining- 1/resolution
        updateRoundTimer(roundTimeRemaining)
    end

    lava1.renderer.visible = false
    lava2.renderer.visible = false
    lava1.position = Vector3.New(0,-7.5,0)
    lava2.position = Vector3.New(0,-21,0)
    
    for i = 1,roundEndTime do
        wait(1)
        roundTimeRemaining = roundTimeRemaining- 1
        updateRoundTimer(roundTimeRemaining)
    end

end

function FourCorners()
    duration = 40
    roundTimeRemaining = duration + roundBeginTime + roundEndTime

    resolution = 5
    print("1")
    possibleColors = {"Red", "Purple", "Blue", "Green"}

    green = GetObjectByName("GreenQuadIndicator")
    red = GetObjectByName("RedQuadIndicator")
    blue = GetObjectByName("BlueQuadIndicator")
    purple = GetObjectByName("PurpleQuadIndicator")
    zoneTable = {red,purple,blue,green}


    greenKill = GetObjectByName("GreenQuadKill")
    greenKill.position = Vector3.New(greenKill.position.x, 12.1, greenKill.position.z)
    redKill = GetObjectByName("RedQuadKill")
    redKill.position = Vector3.New(redKill.position.x, 12.1, redKill.position.z)
    blueKill = GetObjectByName("BlueQuadKill")
    blueKill.position = Vector3.New(blueKill.position.x, 12.1, blueKill.position.z)
    purpleKill = GetObjectByName("PurpleQuadKill")
    purpleKill.position = Vector3.New(purpleKill.position.x, 12.1, purpleKill.position.z)

    killZoneTable = {redKill, purpleKill, blueKill, greenKill}

    print("2")

    dividers = GetObjectsByName("FourSquareDivider")
    for i = 1,#dividers do
        dividers[i].renderer.visible = true
        GetObjectByName("FourSquareBlock").collider.enabled = true
    end

    for i = 1,roundBeginTime do
        wait(1)
        roundTimeRemaining = roundTimeRemaining- 1
        updateRoundTimer(roundTimeRemaining)
    end
    print("3")

    for i = 1,math.floor(duration/10) do
        if not anyPlayersAlive() then
            break
        end
        rngNumber = math.floor(Random.Number(0.5, #possibleColors+0.5) + 0.5)

        zoneTable[rngNumber].renderer.visible = true
        zoneTable[rngNumber].collider.enabled = true

        for j = 1,6*resolution do
            wait(1/resolution)
            roundTimeRemaining = roundTimeRemaining- 1/resolution
            updateRoundTimer(roundTimeRemaining)
        end

        if rngNumber ~= 1 then
            killZoneTable[1].collider.enabled = true
        end
        if rngNumber ~= 2 then
            killZoneTable[2].collider.enabled = true
        end
        if rngNumber ~= 3 then
            killZoneTable[3].collider.enabled = true
        end
        if rngNumber ~= 4 then
            killZoneTable[4].collider.enabled = true
        end

        for j = 1,.2*resolution do
            wait(1/resolution)
            roundTimeRemaining = roundTimeRemaining- 1/resolution
            updateRoundTimer(roundTimeRemaining)
        end

        killZoneTable[1].collider.enabled = false
        killZoneTable[2].collider.enabled = false
        killZoneTable[3].collider.enabled = false
        killZoneTable[4].collider.enabled = false
        for j = 1,1.8*resolution do
            wait(1/resolution)
            roundTimeRemaining = roundTimeRemaining- 1/resolution
            updateRoundTimer(roundTimeRemaining)
        end
        zoneTable[rngNumber].renderer.visible = false
        zoneTable[rngNumber].collider.enabled = false

        for j = 1,2*resolution do
            wait(1/resolution)
            roundTimeRemaining = roundTimeRemaining- 1/resolution
            updateRoundTimer(roundTimeRemaining)
        end

    end
    print("5")
    
    greenKill.position = Vector3.New(greenKill.position.x, -100, greenKill.position.z)
    redKill.position = Vector3.New(redKill.position.x, -100, redKill.position.z)
    blueKill.position = Vector3.New(blueKill.position.x, -100, blueKill.position.z)
    purpleKill.position = Vector3.New(purpleKill.position.x, -100, purpleKill.position.z)

    for i = 1,#dividers do
        dividers[i].renderer.visible = false
        GetObjectByName("FourSquareBlock").collider.enabled = false
    end

    for i = 1,roundEndTime do
        wait(1)
        roundTimeRemaining = roundTimeRemaining- 1
        updateRoundTimer(roundTimeRemaining)
    end

end

function HoleInWall()
    duration = 40
    roundTimeRemaining = duration + roundBeginTime + roundEndTime
    resolution = 60
    speed = 120/6
    walls = {"HoleInWall_Hole1", "HoleInWall_Hole2", "HoleInWall_Hole3", "HoleInWall_Hole4", "HoleInWall_Hole6"}

    local allchar = GetAllAliveCharacters()
    for i = 1,#allchar do
        allchar[i].speed = 1.5
        
    end

    for i = 1,roundBeginTime do
        wait(1)
        roundTimeRemaining = roundTimeRemaining- 1
        updateRoundTimer(roundTimeRemaining)
    end

    for i = 1,math.floor(duration/8) do
        --show
        if not anyPlayersAlive() then
            break
        end
        rngNumber = math.floor(Random.Number(0.5, #walls+0.5) + 0.5)
        wallParts = GetObjectsByName(walls[rngNumber])
        for j = 1,#wallParts do
            wallParts[j].renderer.visible = true
            wallParts[j].collider.enabled = true
            wallParts[j].position = Vector3.New(wallParts[j].position.x, wallParts[j].position.y, -60)
        end

        wait(1)
        roundTimeRemaining = roundTimeRemaining- 1
        updateRoundTimer(roundTimeRemaining)
        
        --move 8 secs 120/8 secs = 
        for j = 1,6*resolution do
            wait(1/resolution)
            roundTimeRemaining = roundTimeRemaining- 1/resolution
            updateRoundTimer(roundTimeRemaining)
            for k = 1,#wallParts do
                wallParts[k].position = wallParts[k].position + Vector3.New(0,0,speed/resolution)
            end
        end

        --pause
        wait(1)
        roundTimeRemaining = roundTimeRemaining- 1
        updateRoundTimer(roundTimeRemaining)

        for j = 1,#wallParts do
            wallParts[j].renderer.visible = false
            wallParts[j].collider.enabled = false
            wallParts[j].position = Vector3.New(wallParts[j].position.x, wallParts[j].position.y, -60)
        end
        --remove onto next
    end

    for i = 1,roundEndTime do
        wait(1)
        roundTimeRemaining = roundTimeRemaining- 1
        updateRoundTimer(roundTimeRemaining)
    end

    local allchar = GetAllAliveCharacters()
    for i = 1,#allchar do
        allchar[i].speed = 1
        
    end
end

function UFOAttack()
    duration = 40
    roundTimeRemaining = duration + roundBeginTime + roundEndTime
    resolution = 60

    for i = 1,roundBeginTime do
        wait(1)
        roundTimeRemaining = roundTimeRemaining- 1
        updateRoundTimer(roundTimeRemaining)
    end

    -- meat of the game

    local UFO = GetObjectByName("UFOMain")
    UFO.renderer.visible = true
    UFO.collider.enabled = true
    for i,v in ipairs(UFO.GetAllChildren()) do
        v.renderer.visible = true
        v.collider.enabled = true
    end
    UFO.GetChildByName("UFOBeam").renderer.color = Color.New(0.33,0.33,1)
    UFO.GetChildByName("UFOBeam").renderer.visible = false
    UFO.GetChildByName("UFOBeam").collider.enabled = false

    for i = 1,duration/2.5 do
        if not anyPlayersAlive() then
            break
        end
        --run every 2.5 seconds
        local currentpos = UFO.position

        local targetPlayer = Random.NumberRounded(1,2)

        local target = Vector3.New(Random.NumberRounded(-50,50),UFO.position.y,Random.NumberRounded(-50,50))
        if targetPlayer == 1 then
            local validplayer = false
            local counter = 1
            while not validplayer and counter < 10 do
                local playersalive = GetAllAliveCharacters()
                local thisPlayer = playersalive[Random.NumberRounded(1,#playersalive)]
                counter = counter + 1
                if IsValid(object.localTable[thisPlayer.player.netId.."alive"]) then
                    if object.localTable[thisPlayer.player.netId.."alive"] == true then
                        validplayer = true
                        vec1 = Vector3.New(thisPlayer.position.x, 0, thisPlayer.position.z)
                        vec2 = Vector3.New(UFO.position.x, 0, UFO.position.z)
                        vector = Vector3.Normalize(vec1 - vec2) * 10
                        --target = Vector3.New(vector.x, UFO.position.y, vector.z)
                        target = Vector3.New(thisPlayer.position.x+vector.x,UFO.position.y,thisPlayer.position.z+vector.z)
                        UFO.GetChildByName("UFOBeam").renderer.color = Color.New(1,0.15,0.15)
                        print("UFO ".. tostring(UFO.position))
                        print("Player " .. tostring(thisPlayer.position))
                        print("Vec ".. tostring(vector))
                    end
                end
            end
        end
        wait(0.5)
        roundTimeRemaining = roundTimeRemaining - 0.5
        updateRoundTimer(roundTimeRemaining)

        UFO.GetChildByName("UFOBeam").renderer.visible = true
        UFO.GetChildByName("UFOBeam").collider.enabled = true
        for j = 1,2*resolution do
            wait(1/resolution)
            roundTimeRemaining = roundTimeRemaining - 1/resolution
            updateRoundTimer(roundTimeRemaining)
            UFO.position = Vector3.Lerp(currentpos,target,j/(2*resolution))
        end
        UFO.GetChildByName("UFOBeam").renderer.visible = false
        UFO.GetChildByName("UFOBeam").collider.enabled = false
        UFO.GetChildByName("UFOBeam").renderer.color = Color.New(0.33,0.33,1)
    end


    UFO.renderer.visible = false
    UFO.collider.enabled = false
    for i,v in ipairs(UFO.GetAllChildren()) do
        v.renderer.visible = false
        v.collider.enabled = false
    end

    for i = 1,roundEndTime do
        wait(1)
        roundTimeRemaining = roundTimeRemaining- 1
        updateRoundTimer(roundTimeRemaining)
    end

end

function SpinZone()
    duration = 40
    roundTimeRemaining = duration + roundBeginTime + roundEndTime
    resolution = 30
    angularspeed1 = Random.NumberRounded(25,35)
    angularspeed2 = Random.NumberRounded(25,35)
    spinner1 = GetObjectByName("HighSpinner")
    spinner1TargetHeight = 18.5
    spinner2 = GetObjectByName("LowSpinner")
    spinner2TargetHeight = 13.5

    spinner1.rotation = Vector3.New(0,315,0)
    spinner2.rotation = Vector3.New(0,315,0)
    for i = 1,roundBeginTime do
        wait(1)
        roundTimeRemaining = roundTimeRemaining- 1
        updateRoundTimer(roundTimeRemaining)

        spinner1.position = Vector3.Lerp(Vector3.New(spinner1.position.x, spinner1TargetHeight-10, spinner1.position.z), Vector3.New(spinner1.position.x, spinner1TargetHeight, spinner1.position.z), i/(roundBeginTime))
        spinner2.position = Vector3.Lerp(Vector3.New(spinner2.position.x, spinner2TargetHeight-10, spinner2.position.z), Vector3.New(spinner2.position.x, spinner2TargetHeight, spinner2.position.z), i/(roundBeginTime))
    end

    for i = 1,3 do
        wait(1)
        roundTimeRemaining = roundTimeRemaining - 1
        updateRoundTimer(roundTimeRemaining)
    end

    reverse1 = Random.NumberRounded(5,17)
    reverse2 = Random.NumberRounded(23,35)
    dir = 1
    
    for i = 1,(duration-3)*resolution do
        if not anyPlayersAlive() then
            break
        end

        wait(1/resolution)
        roundTimeRemaining = roundTimeRemaining - 1/resolution
        updateRoundTimer(roundTimeRemaining)

        if i == (reverse1 * resolution) then
            dir = dir * -1
        elseif i == (reverse2 * resolution) then
            dir = dir * -1
        end

        spinner1.rotation = Vector3.New(0,spinner1.rotation.y + (angularspeed1/resolution) * dir * (1+2*i/((duration-3)*resolution)),0)
        spinner2.rotation = Vector3.New(0,spinner2.rotation.y - (angularspeed2/resolution) * dir * (1+2*i/((duration-3)*resolution)),0)
    end

    for i = 1,roundEndTime*resolution do
        wait(1/resolution)
        roundTimeRemaining = roundTimeRemaining- 1/resolution
        updateRoundTimer(roundTimeRemaining)

        spinner1.rotation = Vector3.New(0,spinner1.rotation.y + (angularspeed1/resolution) * dir * 3-3*(i/(roundEndTime*resolution)),0)
        spinner2.rotation = Vector3.New(0,spinner2.rotation.y - (angularspeed2/resolution) * dir * 3-3*(i/(roundEndTime*resolution)),0)
        spinner1.position = Vector3.Lerp(Vector3.New(spinner1.position.x, spinner1TargetHeight, spinner1.position.z), Vector3.New(spinner1.position.x, spinner1TargetHeight-10, spinner1.position.z), i/(roundBeginTime*resolution))
        spinner2.position = Vector3.Lerp(Vector3.New(spinner2.position.x, spinner2TargetHeight, spinner2.position.z), Vector3.New(spinner2.position.x, spinner2TargetHeight-10, spinner2.position.z), i/(roundBeginTime*resolution))
    end
end