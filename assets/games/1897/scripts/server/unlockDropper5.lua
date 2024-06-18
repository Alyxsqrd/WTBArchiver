local price = 500000
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

            local dropperPartsName = "Tycoon"..tycoonid.."Dropper5Part"
            local dropperParts = GetObjectsByName(dropperPartsName)
            local dropperSpawnerName = "Tycoon"..tycoonid.."Dropper5Spawner"
            local dropperSpawner = GetObjectByName(dropperSpawnerName)
            local displayName = "Tycoon" .. tycoonid .. "MoneyDisplay"
            local displayText = GetObjectByName(displayName)
            local upgradeTextName = "Tycoon" .. tycoonid .. "Unlock4Text"
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
                for i =1,#dropperParts do
                    dropperParts[i].renderer.visible = true
                    dropperParts[i].collider.enabled = true
                end
                dropperSpawner.renderer.visible = true
                dropperSpawner.collider.enabled = true

                -- Next Upgrade Unlock
                
                local nextUpgradeName = "Tycoon"..tycoonid.."Upgrade17"
                local nextUpgrade = GetObjectByName(nextUpgradeName)
                nextUpgrade.renderer.visible = true
                nextUpgrade.collider.enabled = true
                local nextUpgradeTextName = "Tycoon"..tycoonid.."Upgrade17Text"
                local nextUpgradeText = GetObjectByName(nextUpgradeTextName)
                nextUpgradeText.worldText.enabled = true
                
            end
        end
    end
end