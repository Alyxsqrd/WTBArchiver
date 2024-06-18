
function OnPlayerJoin(playerzz)
    wait(2)
    print("FINDING AVAILABLE MONEY DISPLAY FOR : "..playerzz.username)
    local displays = GetObjectsByName("playerCash")

    local assigned = false

    for i = 1,#displays do
        if assigned == false then
            if displays[i].netTable.Target == nil then
                assigned = true
                displays[i].netTable.Target = playerzz.username
                print("ASSIGNED MONEY DISPLAY"..i.." TO PLAYER "..playerzz.username)
                tycoonAssigned = false
                for j = 1,6 do
                    if tycoonAssigned == false then
                        local test = GetObjectsByName("Tycoon"..j)[1]
                        if IsValid(test) then
                            if GetObjectByName("Tycoon"..j).netTable.Owner == "NOBODY" then
                                displays[i].netTable.Owner = "Tycoon"..j
                                GetObjectByName("Tycoon"..j).netTable.Owner = playerzz.username
                                print("ASSIGNED TYCOON"..j.." TO PLAYER "..playerzz.username)
                                SendSystemChatToAll(playerzz.username.." has been assigned Winter Village "..j.."!")
                                tycoonAssigned = true
                            else
                                print("FAILED TO ASSIGN TYCOON"..j.." TO PLAYER "..playerzz.username)
                            end
                        else
                            print("COULD NOT FIND TYCOON"..j)
                        end
                    end
                end
            else
            print("MONEY DISPLAY "..i.." ALREADY ASSIGNED")
            end
        end
    end
end

function OnPlayerLeave(playerzz)
    print(playerzz.username)
    local displays = GetObjectsByName("playerCash")
    for i,v in pairs(displays) do
        if v.netTable.Target == playerzz.username then
            assigned = false
            v.netTable.Target = "NOBODY"
        end
    end
end
