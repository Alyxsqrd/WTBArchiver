object.localTable["unitsAlive"] = 0

function Begin()
    print("2")

    --[[ WAVES ]]
    local roundNumber = 0
    local reserveUnits = 0

    local unitsRoundBase = 5 -- units in round 1
    local unitsRoundIncrement = 1 -- this many more units per each hgher round
    local fastSpawn = 3
    local slowSpawn = 2

    while true do
        wait(5)
        --[[ PLAYER MANAGEMENT ]]
        local objectTable = GetAllCharacters()

        for i = 1,#objectTable do
            print(objectTable[i].username)
            local playerManagerList = GetObjectsByName("playerManager")

            local debounce = 0
            for j = 1,#playerManagerList do
                print("player manager "..j.." has owner ".. playerManagerList[j].netTable.Owner)
                if (playerManagerList[j].netTable.Owner == objectTable[i].username) then
                    debounce = 1
                end
            end

            if (debounce == 0) then
                local playerData = GetObjectByName("playerManager")
                local thisPlayerData = DuplicateObject(playerData)
                thisPlayerData.netTable.Owner = objectTable[i].username
                thisPlayerData.netTable.Cash = 0
                thisPlayerData.netTable.Kills = 0
            end
        end 

        --[[ ROUND MANAGEMENT ]]
        if object.localTable.unitsAlive == 0 then
            if reserveUnits == 0 then
                --[[ BEGIN NEW ROUND ]]
                roundNumber = roundNumber + 1
                reserveUnits = unitsRoundBase + ((roundNumber-1) * unitsRoundIncrement)
                SendSystemChatToAll("New Round With Reserve Units:"..reserveUnits.." RoundNumber:"..roundNumber)
            else
                SendSystemChatToAll("Spawning Enemies...")
                --[[ NO ACTIVE ENEMIES, SPAWN FAST ]]
                for i=1,fastSpawn do
                    if reserveUnits > 0 then
                        local spawnCheck = spawnEnemy()
                        if spawnCheck == true then
                            reserveUnits = reserveUnits - 1
                            object.localTable.unitsAlive = object.localTable.unitsAlive + 1
                            print("Spawned enemy succesfully")
                        else
                            print("Unable to find an inactive enemy to spawn")
                        end
                    end
                end
            end
        else
            --[[ UNITS ALIVE, SPAWN SLOW ]]
            if reserveUnits > 0 then
                SendSystemChatToAll("Spawning Enemies...")
                for i=1,slowSpawn do
                    if reserveUnits > 0 then
                        local spawnCheck = spawnEnemy()
                        if spawnCheck == true then
                            reserveUnits = reserveUnits - 1
                            object.localTable.unitsAlive = object.localTable.unitsAlive + 1
                            print("Spawned enemy succesfully")
                        else
                            print("Unable to find an inactive enemy to spawn")
                        end
                    else
                        --skip
                    end
                end
            else
                SendSystemChatToAll("Destroy the remaining enemies to continue...")
            end
        end
    end
end

function spawnEnemy()
    enemySpawn = GetObjectsByName("gameEnemy")
    local successBool = false
    for i = 1,#enemySpawn do
        if enemySpawn[i].localTable.Active == false then
            --enemySpawn.netTable.Health = 10
            --[[ SPAWN POSITION CODE: CURRENTLY STATIC, CHANGE TO SPAWN POINTS ]]
            enemySpawn[i].position = Vector3.New(Random.Number(-30.0,30.0), 1, -45)

            enemySpawn[i].localTable.Active = true
            successBool = true
            return successBool
        end
    end
    return successBool
end
