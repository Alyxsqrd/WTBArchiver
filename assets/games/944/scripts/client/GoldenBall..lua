local goldenBall = PartByName("Golden Ball")
local playerManager = PartByName("Player Manager")

local itPlayer = nil


function Update()
    if (playerManager != nil) then
        if (playerManager.table["taggerNetId"] != nil) then
            local taggerNetId = playerManager.table["taggerNetId"]
            if (itPlayer == nil or itPlayer.id != taggerNetId) then
                itPlayer = PlayerByID(taggerNetId)
            end
            if (itPlayer == nil) then
                --print("Can't find it player via netId")
                goldenBall.position = newVector3(0, -100, 0)
                return
            end

            goldenBall.position = itPlayer.position
        end
    end
end