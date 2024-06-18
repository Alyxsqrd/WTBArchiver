object.netTable["Health"] = 10
object.netTable["Speed"] = 2 -- movement per second
object.netTable["Smoothness"] = 20 -- ticks per second
object.netTable["Damage"] = 1
object.netTable["Armor"] = 1
object.netTable["Type"] = 1

object.localTable["Destination"] = Vector3.New(0,1,0)
object.localTable["Active"] = false

local timetoDeath = 120 -- failsafe, die after ~2 mins
local tracker = 0
local reward = 5 --placeholder

function Begin()
    while true do
        wait(1 / object.netTable.Smoothness)
        if (object.localTable.Active == true) then 
            
            --[[ Calculate Movement from speed and target position ]]
            tracker = tracker+( 1/object.netTable.Smoothness )
            local movementVector = object.localTable.Destination - object.position
            local mag = math.sqrt(movementVector.x^2 + movementVector.y^2 + movementVector.z^2)
            local dir = Vector3.New(movementVector.x / mag,movementVector.y / mag,movementVector.z / mag) * object.netTable.Speed/object.netTable.Smoothness

            if mag > 1 then
                object.position = object.position + dir
            end

            --[[ Failsafe ]]
            if tracker >= timetoDeath then
                tracker = Death()
            end

        end
    end
end

function OnTouchBegin(touched)
    players = GetObjectsByName("playerManager")
    print(touched.username)
    for i = 1,#players do
        if players[i].netTable.Owner == touched.username then
            players[i].netTable.Kills = players[i].netTable.Kills + 1
            players[i].netTable.Cash = players[i].netTable.Cash + reward
            SendSystemChatToAll(touched.username.." Now Has ".. players[i].netTable.Kills .. " Kill and ".. players[i].netTable.Cash .." Cash")
            tracker = Death()
        end
    end
end

function Death()
    --[[ move offscreen and turn inactive and reduce aliveunit counter in gameManager ]]
    object.localTable.Active = false
    object.position = Vector3.New(-75,1,-75)
    GetObjectByName("gameManager").localTable.unitsAlive = GetObjectByName("gameManager").localTable.unitsAlive - 1

    print('enemy has expired')
    return 0
end