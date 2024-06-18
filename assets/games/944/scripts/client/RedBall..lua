--[[
local redBall = PartByName("Red Ball")
local playerManager = PartByName("Player Manager")

local itPlayer = nil


function Update()
    if (playerManager != nil) then
        if (playerManager.table["lastTaggedNetId"] != nil) then
            local lastTaggedNetId = playerManager.table["lastTaggedNetId"]
            local taggerNetId = playerManager.table["taggerNetId"]

            if (lastTaggedNetId == taggerNetId) then
                redBall.position = newVector3(0, -100, 0)
                return
            end
            if (itPlayer == nil or itPlayer.id != lastTaggedNetId) then
                itPlayer = PlayerByID(lastTaggedNetId)
            end
            if (itPlayer == nil) then
                print("Can't find lastTagged player via netId")
                return
            end

            redBall.position = itPlayer.position
        end
    end
end
]]