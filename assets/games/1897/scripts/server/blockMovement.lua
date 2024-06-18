object.netTable["tycoonid"] = 1
object.netTable["Value"] = 5
object.netTable["tycoonLevel"] = 1

function InitializeFunction()

    --object.netTable["Upgrade1Active"] = false
    --print(object.netTable.tycoonid)
    --print(object.netTable.Value)
    --print(object.netTable.tycoonLevel)
    --print(object.netTable.upgrade1Active)
    --MainLoop()
end
--[[
function MainLoop()
    while true do
        wait(.05)
        if object.name == "PelletTemplate" then
            break()
        end
        local speed = 10
        local collectorButtonName = "Tycoon"..object.netTable.tycoonid.."CollectorTouch"
        local collector = GetObjectByName(collectorButtonName)
        

        if object.netTable.tycoonLevel == 1 then
            local destinationName = "Tycoon"..object.netTable.tycoonid.."CollectorTouch"
            local destination = GetObjectByName(destinationName)
            object.netTable["Destination"] = destination.position
            print(object.netTable.Destination)
        elseif object.netTable.tycoonLevel == 2 then
            local destinationName = "Tycoon"..object.netTable.tycoonid.."Collector2"
            local destination = GetObjectByName(destinationName)
            print(destinationName)
            print(destination)
            object.netTable["Destination"] = destination.position
            print(object.netTable.Destination)
        else
            print("FAILURE")
            --return nil
        end


        local collectorTextName = "Tycoon"..object.netTable.tycoonid.."CollectorText"
        local collectorText = GetObjectByName(collectorTextName)
        if(object.position.y < 10) then --ensure template does nto move
            if(object.position.y > 2) then
                if(object.position.y < 7) then
                    object.position = (object.position + Vector3.New(0,-speed/25,0))
                elseif(object.position.y > 8) then
                    object.position = (object.position + Vector3.New(0,-speed/25,0))
                else
                    object.position.y = 7.75
                    object.position = (object.position + Vector3.New(-speed/100,0,0))
                end
            else
                object.position.y = 2
                object.position = (object.position + Vector3.New(-speed/100,0,0))
            end
        end

        print(object.netTable.Destination)
        print(object.netTable.Destination)
        local xdis = (object.position.x - object.netTable.Destination.x)
        local ydis = (object.position.y - object.netTable.Destination.y)
        local zdis = (object.position.z - object.netTable.Destination.z)
        if(math.sqrt(xdis^2+ydis^2+zdis^2) < 1) then
            collector.netTable.moneyInStorage = collector.netTable.moneyInStorage + object.netTable.Value
            collectorText.worldText.text = ""..collector.netTable.moneyInStorage.."$"
            DeleteObject(object)
            print("Collector"..object.netTable.tycoonid.." Now Has "..collector.netTable.moneyInStorage.."$")

        end
    end
end]]