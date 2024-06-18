local intermissionDuration = 30
local roundTime = 90
local currentWord = ""
local winners = {}
local drawer = nil
local votesToRemoveDrawer = {}
local locallyHovered = false

local words = {"pumpkin","rainbow","flower","baby","bible","sand castle","snowflake","book","bikini","ufo","glasses","stairs","starfish","star","high heel","ice cream","igloo","strawberry","bee","bucket","camera","lady bug","lamp","moth","tire","car","cat","lion","mail","toast","church","tooth","toothbrush","toothpaste","night","moon","sun","crayon","nose","ear","hair","beard","eyes","truck","soccer","egg","peanut","brain","rain","bus","castle","lobster","slipper","lollipop","snowball","mermaid","centaur","goblin","tree","dragon","computer","keyboard","mouse","piano","owl","flag","ferris wheel","nurse","space","koala","bigfoot","facebook","tiktok","youtube","instagram","wifi","internet","mom","dad","photo","pirate","alien","zombie","golf","kiss","pancake","jellyfish","spider","mummy","candy","money","chocolate","laptop","cloud","plate","fork","spoon","candle","guitar","pillow","shirt","pants","watch","clock","ice","ice cube","witch","scarf","tie","socks","phone","paper clip","calendar","desk","sticky note","whistle","lemon","bubble","ketchup","cupcake","battery","train","plane","superhero","spiderman","batman","mars","earth","beach","mountain","frog","scorpion","baby yoda","spongebob","vampire","shrek","yoshi","mario","harry potter","cinderella","pikachu","snoring","monday","friday","helmet","pig","kite","christmas tree","doctor","spider web","bike","gas station","river","rock","smurf","star wars","nemo","iron man","hulk","corn","watermelon","orange","banana","minions","spaghetti","pizza","apple","donut","cookie","cheese","bacon","sandwich","smile","teeth","heart","island","artist","voxel","game","chef","president","among us","call of duty","fortnite","gorilla"}


function Begin()
    printScreen("There are "..#words.." words", 5, Color.New(1,0,0))

    branch("DrawingLoop")

    if isHost then
        ResetGame()
        ServerResetSettings()
    else
        return
    end

    while true do
        Intermission()
        Round()
    end
end

function OnMouseEnter()
    locallyHovered = true
end

function OnMouseExit()
    locallyHovered = false
end

function DrawingLoop()
    while true do
        waitPhysicsTick(5)
        if locallyHovered and Input.LeftMouseHeld() and drawer == GetLocalPlayer() then
            local paintPosition = Input.mouseWorldPosition
            this.RunOnServer("Draw", paintPosition, paintColor)
        end
    end 
end

function ChooseColor(color)
    if drawer == GetLocalPlayer() then
        this.RunOnServer("Server_ChooseColor", color)
    end
end

function Server_ChooseColor(color)
    object.netTable["color"] = Color.HexFromColor(color)
end

function ChooseSize(size)
    if drawer == GetLocalPlayer() then
        this.RunOnServer("Server_ChooseSize", size)
    end
end

function Server_ChooseSize(size)
    object.netTable["size"] = size
end

function Draw(pos)
    local obj = GetObjectByName("PaintOriginal").Duplicate()
    obj.name = "Paint"
    obj.position = pos
    obj.size = Vector3.New(object.netTable["size"], object.netTable["size"], object.netTable["size"])
    obj.renderer.color = Color.ColorFromHex(object.netTable["color"])
end

function Intermission()
    wait(1)

    SendSystemChatToAll("Intermission")

    for i=intermissionDuration,0,-1 do
        GetObjectByName("Timer").worldText.text = i
        wait(1)
    end
end

function Client_SetDrawer(newDrawer)
    drawer = newDrawer
end

function Round()
    drawer = Random.Player()
    this.RunOnAllClients("Client_SetDrawer", drawer)
    GetObjectByName("Timer").worldText.text = drawer.nickname
    SendSystemChatToAll("New round, "..drawer.nickname.." is drawing!")
    drawer.RespawnAt(GetObjectByName("DrawerSpawn").respawn)

    currentWord = GetRandomWord()
    drawer.SendSystemChat("The secret word is "..currentWord..", draw it as a picture!")

    wait(2)

    for i=roundTime,0,-1 do
        GetObjectByName("Timer").worldText.text = i
        wait(1)
        if #winners == #GetAllPlayers()-1 and #winners > 0 then
            break
        end
        if #votesToRemoveDrawer >= Math.RoundUp((#GetAllPlayers())/2) and #GetAllPlayers() > 2 then
            break
        end
    end

    -- determine winners
    local winnersText = ""
    if #winners == 0 then
        winnersText = "None!"
    else
        for i=1,#winners do
            if winnersText == "" then
                -- do nothing
            else
                winnersText = winnersText..", "
            end
            winnersText = winnersText..winners[i].nickname
        end
    end
    SendSystemChatToAll("The word was "..currentWord.."! Winners: "..winnersText)
    GetObjectByName("Timer").worldText.text = currentWord

    -- clear winners
    ResetGame()
end

function ServerResetSettings()
    object.netTable["size"] = 1
    object.netTable["color"] = Color.HexFromColor(Color.New(0,0,0))
end

function ResetGame()
    currentWord = ""
    winners = {}
    votesToRemoveDrawer = {}
    if IsValid(drawer) then
        drawer.Respawn()
    end
    for i,v in ipairs(GetObjectsByName("Paint")) do
        DeleteObject(v)
    end
end

function GetRandomWord()
    return words[Random.NumberRounded(0, #words)]
end

function OnPlayerChat(player, message)
    local lowerMessage = string.lower(message)

    if lowerMessage == currentWord and player.netId ~= drawer.netId and currentWord ~= "" then
        for i,v in ipairs(winners) do
            if v.netId == player.netId then
                return
            end
        end
        table.insert(winners, player)
        player.SendSystemChat("CORRECT! You got the secret word, "..currentWord.."!")
    end
end

function VoteRemoveDrawer(player)
    for i,v in ipairs(votesToRemoveDrawer) do
        if v.netId == player.netId then
            return
        end
    end
    table.insert(votesToRemoveDrawer, player)
end