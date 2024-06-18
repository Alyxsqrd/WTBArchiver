local price = 125000
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

local purchased = false

function OnTouchBegin(touched)
    --if owner
    if (object.renderer.visible == true) then
        if purchased == false then 
            local tycoonName = "TycoonEntity"..tycoonid
            local tycoon = GetObjectByName(tycoonName)

            if tycoon.netTable.Owner ~= touched.player.username then
                return nil
            end

            local dropperName = "Tycoon"..tycoonid.."Dropper4"
            local dropper = GetObjectByName(dropperName)
            local displayName = "Tycoon" .. tycoonid .. "MoneyDisplay"
            local displayText = GetObjectByName(displayName)
            local upgradeTextName = "Tycoon" .. tycoonid .. "Upgrade14Text"
            local upgradeText = GetObjectByName(upgradeTextName)
            if tycoon.netTable.Money >= price then
                --upgrade
                purchased = true
                dropper.netTable.dropValue = dropper.netTable.dropValue + 5000
                --dropper.netTable.dropSize = dropper.netTable.dropSize + Vector3.New(0.1,0.1,0.1)
                tycoon.netTable.Money = tycoon.netTable.Money - price
                displayText.worldText.text = "Money: "..tycoon.netTable.Money.."$"
                local holder = upgradeText.worldText.text
                upgradeText.worldText.text = "PURCHASED: "..holder
                object.renderer.color = Color.New(100/255, 100/255, 100/255)
                upgradeText.worldText.enabled = false
                -- Next Upgrade Unlock(s)
                local nextUpgradeName = "Tycoon"..tycoonid.."Upgrade15"
                local nextUpgrade = GetObjectByName(nextUpgradeName)
                nextUpgrade.renderer.visible = true
                nextUpgrade.collider.enabled = true
                local nextUpgradeTextName = "Tycoon"..tycoonid.."Upgrade15Text"
                local nextUpgradeText = GetObjectByName(nextUpgradeTextName)
                nextUpgradeText.worldText.enabled = true

                
                print('upgrade 14 purchased')
                print('drop value is now '..dropper.netTable.dropValue)
                --print('drop size is now <x,y,z> : <'..dropper.netTable.dropSize.x..","..dropper.netTable.dropSize.y..","..dropper.netTable.dropSize.z..">")
            end
        end
    end
end