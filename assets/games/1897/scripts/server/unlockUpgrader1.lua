local price = 750
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


--[[
When Adding New
Change:
upgradeTextName
Price
DropperName
what stat is upgraded
next upgrade
]]

function OnTouchBegin(touched)
    --if owner
    if (object.renderer.visible == true) then
        if purchased == false then 
            local tycoonName = "TycoonEntity"..tycoonid
            local tycoon = GetObjectByName(tycoonName)
            
            if tycoon.netTable.Owner ~= touched.player.username then
                return nil
            end

            local upgradePartsName = "Tycoon"..tycoonid.."Upgrade7Part"
            local upgradeParts = GetObjectsByName(upgradePartsName)
            local upgradeMainName = "Tycoon"..tycoonid.."Upgrade7Main"
            local upgradeMain = GetObjectByName(upgradeMainName)
            local upgradeLightsName = "Tycoon"..tycoonid.."Upgrade7Light"
            local upgradeLights = GetObjectsByName(upgradeLightsName)
            local displayName = "Tycoon" .. tycoonid .. "MoneyDisplay"
            local displayText = GetObjectByName(displayName)
            local upgradeTextName = "Tycoon" .. tycoonid .. "Upgrade7Text"
            local upgradeText = GetObjectByName(upgradeTextName)

            if tycoon.netTable.Money >= price then
                --upgrade
                purchased = true
                tycoon.netTable.Money = tycoon.netTable.Money - price
                displayText.worldText.text = "Money: "..tycoon.netTable.Money.."$"
                local holder = upgradeText.worldText.text
                upgradeText.worldText.text = "PURCHASED: "..holder
                object.renderer.color = Color.New(100/255, 100/255, 100/255)
                upgradeText.worldText.enabled = false
                for i =1,#upgradeParts do
                    upgradeParts[i].renderer.visible = true
                    upgradeParts[i].collider.enabled = true
                end
                for i =1,#upgradeLights do
                    upgradeLights[i].light.enabled = true
                end
                upgradeMain.collider.enabled = true


                -- Next Upgrade Unlock
                --[[
                local nextUpgradeName = "Tycoon"..tycoonid.."Upgrade4"
                local nextUpgrade = GetObjectByName(nextUpgradeName)
                nextUpgrade.renderer.visible = true
                nextUpgrade.collider.enabled = true
                local nextUpgradeTextName = "Tycoon"..tycoonid.."Upgrade4Text"
                local nextUpgradeText = GetObjectByName(nextUpgradeTextName)
                nextUpgradeText.worldText.enabled = true
                ]]
                
                print('upgrader unlocked')
            end
        end
    end
end