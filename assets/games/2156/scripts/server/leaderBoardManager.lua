function Begin()
    -- THIS IS THE DISASTERS VERSION
        -- THIS IS THE DISASTERS VERSION
            -- THIS IS THE DISASTERS VERSION
                -- THIS IS THE DISASTERS VERSION
                    -- THIS IS THE DISASTERS VERSION
                        -- THIS IS THE DISASTERS VERSION
                            -- THIS IS THE DISASTERS VERSION
                                -- THIS IS THE DISASTERS VERSION
                                    -- THIS IS THE DISASTERS VERSION
                                        -- THIS IS THE DISASTERS VERSION
                                            -- THIS IS THE DISASTERS VERSION
                                                -- THIS IS THE DISASTERS VERSION
                                                    -- THIS IS THE DISASTERS VERSION
                                                        -- THIS IS THE DISASTERS VERSION

    for i =1,1 do
        print("Running")
    end
end

function OnNetMessage(messageTable)
    
    --update stat
    if messageTable[1] == 1 then
        updateStat(messageTable[2], messageTable[3], messageTable[4])
    end

    --update display
    if messageTable[1] == 2 then
        updateDisplay()
    end

    --buy upgrade
   if messageTable[1] == 3 then
        --(Player, Upgrade, Price)
        buyUpgrade(messageTable[2], messageTable[3], messageTable[4])
   end
end

function buyUpgrade(pleyr, upgradeID, UPGprice)
    print(pleyr)
    print(upgradeID)
    print(UPGprice)
    if IsValid(object.localTable[pleyr.."Wins"]) then
        if upgradeID == 1 then
            if object.localTable[pleyr.."Wins"] >= UPGprice then
                local char = GetPlayerByNetId(pleyr).character
                char.speed = 1.3
            end
        end
        if upgradeID == 2 then
            if object.localTable[pleyr.."Wins"] >= UPGprice then
                local char = GetPlayerByNetId(pleyr).character
                char.gravityPower = 0.5
            end
        end
        if upgradeID == 3 then
            if object.localTable[pleyr.."Wins"] >= UPGprice then
                local char = GetPlayerByNetId(pleyr).character
                char.scale = 1.3
            end
        end
        if upgradeID == 4 then
            if object.localTable[pleyr.."Wins"] >= UPGprice then
                local char = GetPlayerByNetId(pleyr).character
                char.scale = 0.7
            end
        end
        if upgradeID == 5 then
            if object.localTable[pleyr.."Wins"] >= UPGprice then
                local char = GetPlayerByNetId(pleyr).character
                char.gravityPower = -1
            end
        end
        if upgradeID == 6 then
            if object.localTable[pleyr.."Wins"] >= UPGprice then
                local char = GetPlayerByNetId(pleyr).character
                char.gravityPower = 1.3
            end
        end
    end
end

function validStatStorage()
    local playerz = GetAllPlayers()

    for i = 1,#playerz do
        if IsValid(object.localTable[playerz[i].netId.."Wins"]) then else
            object.localTable[playerz[i].netId.."Wins"] = 0
        end
    end
    for i = 1,#playerz do
        if IsValid(object.localTable[playerz[i].netId.."Points"]) then else
            object.localTable[playerz[i].netId.."Points"] = 0
        end
    end
end

function updateStat(playor, stat, amount)
    validStatStorage()

    
    if stat == 1 then
        statString = "Wins"
    elseif stat == 2 then
        statString = "Points"
    end
    --print(playor..statString)
    object.localTable[playor..statString] = object.localTable[playor..statString] + amount

    --print(object.localTable[playor..statString])
end


function updateDisplay()
    validStatStorage()
    local playerz = GetAllPlayers()
    local leaderboardSlot = GetObjectByName("leaderboardWinSlot")
    local winSlotCount = GetObjectsByName("leaderboardWinSlot")

    while #winSlotCount ~= #playerz do
        if #winSlotCount > #playerz then
            winSlotCount[#winSlotCount].Delete()
            
            winSlotCount = GetObjectsByName("leaderboardWinSlot")
        elseif #winSlotCount < #playerz then
            winSlotCount[#winSlotCount].Duplicate()
            
            winSlotCount = GetObjectsByName("leaderboardWinSlot")
        end
    end

    local pointSlotCount = GetObjectsByName("leaderboardPointSlot")

    while #pointSlotCount ~= #playerz do
        if #pointSlotCount > #playerz then
            pointSlotCount[#pointSlotCount].Delete()
            
            pointSlotCount = GetObjectsByName("leaderboardPointSlot")
        elseif #pointSlotCount < #playerz then
            pointSlotCount[#pointSlotCount].Duplicate()
            
            pointSlotCount = GetObjectsByName("leaderboardPointSlot")
        end
    end


    for i = 1,#playerz do
        winSlotCount[i].worldText.text = playerz[i].nickname .. "   :   " .. object.localTable[playerz[i].netId.."Wins"]

        local spaceMultiplier = 0

        for j = 1,#playerz do

            if (object.localTable[playerz[j].netId.."Wins"] >= object.localTable[playerz[i].netId.."Wins"]) then
                if object.localTable[playerz[j].netId.."Wins"] == object.localTable[playerz[i].netId.."Wins"] and playerz[j].netId < playerz[i].netId then
                
                else
                    spaceMultiplier = spaceMultiplier+1
                end
            end
        end

        winSlotCount[i].position = GetObjectByName("Leaderboard_WinText").position - Vector3.New(0, 0.5 + 1 * spaceMultiplier,0)
    end

    for i = 1,#playerz do
        pointSlotCount[i].worldText.text = playerz[i].nickname .. "   :   " .. object.localTable[playerz[i].netId.."Points"]

        local spaceMultiplier = 0
        
        for j = 1,#playerz do
            if (object.localTable[playerz[j].netId.."Points"] >= object.localTable[playerz[i].netId.."Points"]) then
                if object.localTable[playerz[j].netId.."Points"] == object.localTable[playerz[i].netId.."Points"] and playerz[j].netId < playerz[i].netId then
                
                else
                    spaceMultiplier = spaceMultiplier+1
                end
            end
        end

        pointSlotCount[i].position = GetObjectByName("Leaderboard_PointText").position - Vector3.New(0, 0.5 + 1 * spaceMultiplier,0)
    end
end
