function Begin()
    secsToStart = 30
    roundStarting = false
    roundStarted = false
    GetObjectById(179).worldText.text = "Not Enough Players"
    extraMap = {}
    extraMapPos = {{}}
    table.insert(extraMap,objFillList(189,223))
    initExtraMap()
end

function objFillList(first,last)
    local tempObjList = {}
    for i=first,last,2
    do
        table.insert(tempObjList,i)
    end
    return tempObjList
end

function initExtraMap()
    for i=1,#(extraMap),1
    do
        for ii = 1,#(extraMap[i]),1
        do
            table.insert(extraMapPos[i],GetObjectById(extraMap[i][ii]).position)
            GetObjectById(extraMap[i][ii]).position = Vector3.New(0,-100,0)
        end
    end
end

function loadExtraMap(mapIndex)
    for i=1,#(extraMap[mapIndex]),1
    do
        GetObjectById(extraMap[mapIndex][i]).position = extraMapPos[mapIndex][i]
    end
end
function unloadExtraMap(mapIndex)
    for i=1,#(extraMap[mapIndex]),1
    do
        GetObjectById(extraMap[mapIndex][i]).position = Vector3.New(0,-100,0)
    end
end

function countDown()
    if roundStarting == true
    then
        if secsToStart > 0
        then
            GetObjectById(179).worldText.text = tostring(secsToStart) .. "s"
            secsToStart = secsToStart - 1

            wait(1.0)

            countDown()
        else
            resetRocks()
            chooseTeams()
            teleportToIsland()
            GetObjectById(179).worldText.text = "Round In Progress"
            wait(60.0)
            secsToStart = 30
            teleportToCloud()
            countScore()
            countDown()
        end
    end
end

function teleportToIsland()
    local spawnPos = GetObjectById(181).position

    for i=1,#(GetAllCharacters()),1
    do
        GetAllCharacters()[i].position = spawnPos
        GetAllCharacters()[i].speed = 2
    end
end
function teleportToCloud()
    local spawnPos = GetObjectById(15).position

    for i=1,#(GetAllCharacters()),1
    do
        GetAllCharacters()[i].position = spawnPos
        GetAllCharacters()[i].speed = 1
    end
end

function OnPlayerJoin(player)
    playerNo = #(GetAllPlayers())

    if playerNo == 3
    then
        print("Loading Extra Map 1...")
        loadExtraMap(1)
    end

    if playerNo == 2
    then
        roundStarting = true
        countDown()
    end
end
function OnPlayerLeave(player)
    playerNo = #(GetAllPlayers())

    if playerNo == 2
    then
        print("Unloading Extra Map 1...")
        unloadExtraMap(1)
    end

    if playerNo < 2
    then       
        secsToStart = 30
        roundStarting = false
        roundStarted = false
        GetObjectById(179).worldText.text = "Not Enough Players"
        teleportToCloud()
    end
end

function chooseTeams()
    local currentColour = "Red"
    
    for i=1,#(GetAllCharacters()),1
    do
        if currentColour == "Red"
        then
            GetAllCharacters()[i].gravityPower = 1.0
            print("Red")
            currentColour = "Blue"
        else
            GetAllCharacters()[i].gravityPower = 1.001
            print("Blue")
            currentColour = "Red"
        end
    end
    
end

function countScore()
    local redPoints = #(GetObjectsByName("RedRock"))
    local bluePoints = #(GetObjectsByName("BlueRock"))
    if redPoints > bluePoints
    then
        GetObjectById(187).worldText.text = "Red"
        GetObjectById(187).worldText.color = Color.New(255, 0, 0)
        SendSystemChatToAll("Red Wins with " .. tostring(redPoints) .. " to " .. tostring(bluePoints) .. "!")
    else
        if bluePoints > redPoints
        then
            GetObjectById(187).worldText.text = "Blue"
            GetObjectById(187).worldText.color = Color.New(0, 0, 255)
            SendSystemChatToAll("Blue Wins with " .. tostring(bluePoints) .. " to " .. tostring(redPoints) .. "!")
        else
            GetObjectById(187).worldText.text = "Draw"
            GetObjectById(187).worldText.color = Color.New(0, 0, 0)
            SendSystemChatToAll("Draw with " .. tostring(redPoints) .. " Each!")
        end
    end
end

function resetRocks()
    for i=1,#(GetObjectsByName("RedRock")),1
    do
        GetObjectsByName("RedRock")[i].renderer.color = Color.ColorFromHex("#454545")
        GetObjectsByName("RedRock")[i].name = "Rock"
    end
    for i=1,#(GetObjectsByName("BlueRock")),1
    do
        GetObjectsByName("BlueRock")[i].renderer.color = Color.ColorFromHex("#454545")
        GetObjectsByName("BlueRock")[i].name = "Rock"
    end
    print(tostring(#(GetObjectsByName("BlueRock"))))
end
