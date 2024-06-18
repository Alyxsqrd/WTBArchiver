function Begin()
    blockPrefab = GetObjectByName("BlockPrefab")
    roundTimer = GetObjectByName("RoundTimer")
    roundTimer2 = GetObjectByName("RoundTimer2")
    startPos = GetObjectByName("PlayerStart").position
    currentBuilder = GetObjectById(166)
    respawn = GetObjectByName("Respawn")

    currentBuilderPlayer = nil

    themes = {"Giraffe","Beach","Penguin","Happy","Sword","Sheep","Cow","Dog","Hat","Vegetable","Fruit","Apple","House","Skyscraper","Ferris Wheel","Slide",
    "Sad","Cloud","Bus","Car","Truck","Game","Computer","Pencil","Clock","Road","Chicken","Food","Cushion","Evil","Pancakes","Tornado","UFO","Heart","Rock",
    "Bread","Two","Church","Desk","Chair","Money","Goal","Pen","Salad",
    "Chest","Lady","Person","Bee","Nest","Honey","Chocolate","Camera",
    "Tooth","Bird","Drink","Guitar","Piano","Drum","Ball","Banana","River","Window","Nose","Shoe","You","Skull","Strawberry","Headphones","Igloo","Rainbow","Bed","Lemon",
    "Battery","Frog"
    }
    currentTheme = ""

    playing = false

    correctPlayers = {}
    correctGuesses = 0

    deleteBlocks = false
    blockColour = blockPrefab.renderer.color

    roundTimeLeft = 30

    Event.Bind(this, "placeBlock")
    Event.Bind(this, "changeColour")
    Event.Bind(this, "setDelete")

    math.randomseed(os.time())

    print("HI")

    roundStartCountDown()
end

function OnPlayerChat(player, message)
    if playing then
        for i=1,#correctPlayers,1 do
            if correctPlayers[i] == player.netId then
                return
            end
        end
        if string.find(string.lower(message), string.lower(currentTheme)) then
            player.SendSystemChat("Correct! You Got it Right!")
            table.insert(correctPlayers, player.netId)
            correctGuesses = correctGuesses + 1
            if correctGuesses >= #GetAllPlayers() - 1 then
                roundEnd()
            end
        end
    end
end

function roundStartCountDown()
    if playing == false then
        roundTimer.worldText.text = "Time Until Next Round: "..tostring(roundTimeLeft).."s"
        roundTimer2.worldText.text = "Time Until Next Round: "..tostring(roundTimeLeft).."s"
        if roundTimeLeft - 1 > 0 then
            roundTimeLeft = roundTimeLeft - 1
            wait(1)
            roundStartCountDown()
        else
            roundStart()
        end
    end
end
function roundEndCountDown()
    if playing == true then
        roundTimer.worldText.text = "Time Until Round Ends: "..tostring(roundTimeLeft).."s"
        roundTimer2.worldText.text = "Time Until Round Ends: "..tostring(roundTimeLeft).."s"
        if roundTimeLeft - 1 > 0 then
            roundTimeLeft = roundTimeLeft - 1
            wait(1)
            roundEndCountDown()
        else
            roundEnd()
        end
    end
end

function roundStart()
    correctPlayers = {}
    correctGuesses = 0
    playing = true
    destroyAllBlocks()
    roundTimeLeft = 120
    local players = GetAllCharacters()
    local playerIndex = math.ceil(math.random()*#(players))
    currentBuilder.name = tostring(players[playerIndex].netId)
    SendSystemChatToAll("This Round's Builder is "..players[playerIndex].username.."!")
    players[playerIndex].position = startPos
    currentTheme = themes[math.ceil(math.random()*#(themes))]
    players[playerIndex].player.SendSystemChat("The Theme is "..currentTheme.."! Get Building!")
    currentBuilderPlayer = players[playerIndex]
    table.insert(correctPlayers, players[playerIndex].player.netId)
    roundEndCountDown()
end
function roundEnd()
    playing = false
    roundTimeLeft = 30
    correctPlayers = {}
    correctGuesses = 0
    currentBuilderPlayer.position = respawn.position
    SendSystemChatToAll("The Theme Was "..currentTheme.."!")
    roundStartCountDown()
end

function destroyAllBlocks()
    blocks = GetObjectsByName("pBlock")
    for i=1,#blocks,1
    do
        wait(0.1)
        DeleteObject(blocks[i])
    end
end

function placeBlock(pos,blockId,pId)
    if tostring(pId) == currentBuilder.name then
        if deleteBlocks then
            local tempBlock = GetObjectById(blockId)
            if tempBlock.name == "pBlock" then
                DeleteObject(tempBlock)
            end
        else
            local tempBlock = DuplicateObject(blockPrefab)
            tempBlock.position = pos
            tempBlock.name = "pBlock"
            tempBlock.renderer.color = blockColour
        end
    end
end
function changeColour(colour,pId)
    if tostring(pId) == currentBuilder.name then
        blockColour = colour
        deleteBlocks = false
    end
end
function setDelete(pId)
    if tostring(pId) == currentBuilder.name then
        deleteBlocks = true
    end
end