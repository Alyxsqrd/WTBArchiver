
object.netTable["moneyInStorage"] = 0

local tycoonid = 1
function InitializeFunction()
    local index = string.sub(string.find(object.name, "Tycoon"),1) + 6
    if string.find(object.name, "Tycoon") ~= nil then
        tycoonid = string.sub(object.name, index, index)
        print(object.name .." assigned tycoonid "..tycoonid)
    else
        print('invalid Object')
    end
end

function OnTouchBegin(touched)
    local tycoonName = "TycoonEntity"..tycoonid
    local tycoon = GetObjectByName(tycoonName)
                            
    if touched.player.username ~= tycoon.netTable.Owner then
        return nil
    end
    
    local collectorName = "Tycoon" .. tycoonid .."CollectorText"
    local collectorText = GetObjectByName(collectorName)
    local displayName = "Tycoon" .. tycoonid .. "MoneyDisplay"
    local displayText = GetObjectByName(displayName)
    tycoon.netTable.Money = tycoon.netTable.Money + object.netTable.moneyInStorage
    object.netTable.moneyInStorage = 0
    collectorText.worldText.text = object.netTable.moneyInStorage.."$"
    displayText.worldText.text = "Money: " .. tycoon.netTable.Money .. "$"
    print(tycoon.netTable.Money)
end
