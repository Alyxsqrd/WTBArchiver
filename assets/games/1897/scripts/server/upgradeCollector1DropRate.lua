local price = 25
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

--NOT USED
--NOT USED
--NOT USED
--NOT USED
--NOT USED
--NOT USED
--NOT USED

function OnTouchBegin(touched)
    --if owner
    if (object.renderer.visible == true) then
        if purchased == false then 
            local tycoonName = "TycoonEntity"..tycoonid
            local tycoon = GetObjectByName(tycoonName)
            
            if tycoon.netTable.Owner ~= touched.player.username then
                return nil
            end

            local dropperName = "Tycoon"..tycoonid.."Dropper1"
            local dropper = GetObjectByName(dropperName)
            local displayName = "Tycoon" .. tycoonid .. "MoneyDisplay"
            local displayText = GetObjectByName(displayName)
            local upgradeTextName = "Tycoon" .. tycoonid .. "Upgrade1Text"
            local upgradeText = GetObjectByName(upgradeTextName)
            if tycoon.netTable.Money > price then
                --upgrade
                purchased = true
                dropper.netTable.dropInterval = dropper.netTable.dropInterval - 1
                tycoon.netTable.Money = tycoon.netTable.Money - price
                displayText.worldText.text = "Money: "..tycoon.netTable.Money.."$"

                object.renderer.color = Color.New(100/255, 100/255, 100/255)

                local holder = upgradeText.worldText.text
                upgradeText.worldText.text = "PURCHASED: "..holder

                local nextUpgradeName = "Tycoon"..tycoonid.."Upgrade2"
                local nextUpgrade = GetObjectByName(nextUpgradeName)
                nextUpgrade.renderer.visible = true
                nextUpgrade.collider.enabled = true
                local nextUpgradeTextName = "Tycoon"..tycoonid.."Upgrade2Text"
                local nextUpgradeText = GetObjectByName(nextUpgradeTextName)
                nextUpgradeText.worldText.enabled = true

                print('upgrade 1 purchased')
                print('drop time is now '..dropper.netTable.dropInterval)
            end
        end
    end
end