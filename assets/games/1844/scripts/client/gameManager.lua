local timerText
local difficultyText
local leaderboard
local wall
local safeZone
local lastWallNumber
local numWalls = 12
local intermissionTime = 15
local roundTime = 10
local difficulty = 1

local alivePlayers


function Begin()
    Event.Bind(this, "KillCharacter")

    if isHost then
        wait(3)

        timerText = GetObjectByName("Timer").worldText
        difficultyText = GetObjectByName("Difficulty").worldText
        wall = GetObjectByName("MovingWall")
        leaderboard = GetObjectByName("Leaderboard")
        safeZone = GetObjectByName("SafeZone")

        branch("GameLoop")
    end
end

function GameLoop()
    wait(3)

    while true do
        Intermission()

        difficulty = 0
        alivePlayers = {}
        for i,v in pairs(GetAllCharacters()) do
            if not v.dead then
                table.insert(alivePlayers, v.player)
            end
        end
        local spawn = GetObjectByName("RoundSpawn")
        for i,v in pairs(alivePlayers) do
            v.character.position = spawn.position
            --v.RespawnAt(spawn.respawn)
        end

        while #alivePlayers > 0 and difficulty < 21 do
            Round()
            difficulty = difficulty + 1
            wait(3)
        end
    end
end

function Intermission()
    print("Intermission started")

    local spawn = GetObjectByName("IntermissionSpawn")
    for i,v in pairs(GetAllAliveCharacters()) do
        v.position = spawn.position
        --v.player.RespawnAt(spawn.respawn)
    end

    for i = intermissionTime, 0, -1 do
        timerText.text = "Intermission: " .. i
        wait(1)
    end
end

function Round()
    print("Round started!")

    timerText.text = "Round in progress.."
    difficultyText.text = "Difficulty: " .. difficulty

    local wallNumber = lastWallNumber
    while wallNumber == lastWallNumber do
        wallNumber = Random.NumberRounded(1, numWalls)
    end
    lastWallNumber = wallNumber
    Event.BroadcastToAllPlayers("ChangeWallDesign", "Wall" .. wallNumber)

    local difficultyRoundTime = roundTime - difficulty
    local rt = difficultyRoundTime

    if difficultyRoundTime == 2 then
        rt = 2.5
    end
    if difficultyRoundTime == 1 then
        rt = 2
    end
    if difficultyRoundTime < 1 then
        rt = 1.5
    end
    if difficultyRoundTime < -1 then
        rt = 1
    end
    if difficultyRoundTime < -3 then
        rt = 0.5
    end

    Event.BroadcastToAllPlayers("StartMovingWall", rt)

    wait(difficultyRoundTime)

    for i,v in pairs(GetCharactersInBounds(safeZone.position, Vector3.New(safeZone.size.x, 100, safeZone.size.z))) do
        if not v.dead then
            if not leaderboard.netTable[v.username] then
                leaderboard.netTable[v.username] = 0
            end
            leaderboard.netTable[v.username] = leaderboard.netTable[v.username] + 1
        end
    end
    --for i = roundTime, 0, -1 do
    --    timerText.text = "Round: " .. i
    --    wait(1)
    --end

    --wall.position = GetObjectByName("WallSpawn").position
    --wall.voxelRenderer.design = "BlankWall"
    --wall.collider.enabled = false
    --waitTick(1)
    --wall.collider.enabled = true

    --if IsValid(alivePlayers) then
    --    for i,alivePlayer in pairs(alivePlayers) do
    --        for i,v in pairs(GetAllPlayers()) do -- SendSystemChatToAll not working (11-20-2022)
    --            if not leaderboard.netTable[v.username] then
    --                leaderboard.netTable[v.username] = 0
    --            end
    --            leaderboard.netTable[v.username] = leaderboard.netTable[v.username] + 1
    --        end
    --    end
    --end
end

function OnCharacterDied(character)
    if isHost then
        RemovePlayerFromAlivePlayers(character.player)
    end
end

function RemovePlayerFromAlivePlayers(p)
    for i,v in pairs(alivePlayers) do
        if v == p then
            table.remove(alivePlayers, i)
        end
    end
end

function KillCharacter(c)
    if isHost then
        c.Kill()
    else
        this.RunOnServer("KillCharacter", c)
    end
end