object.netTable["dropInterval"] = 10 -- reduced to 2 with upgrade 1
object.netTable["dropValue"] = 500
object.netTable["dropNumber"] = 1
object.netTable["dropSize"] = Vector3.New(0.25,0.2,0.25)
local tycoonid = 1
function InitializeFunction()
    local index = string.sub(string.find(object.name, "Tycoon"),1) + 6
    
    if string.find(object.name, "Tycoon") ~= nil then
        tycoonid = string.sub(object.name, index, index)
        print(object.name .." assigned tycoonid "..tycoonid)
    else
        print('invalid Object')
    end

    if tycoonid ~= 0 then


        mainLoop()
    end
end

function mainLoop()
    local spawnerName = "Tycoon" .. tycoonid .. "Dropper3Spawner"
    local spawner = GetObjectByName(spawnerName)
    local template = GetObjectByName("PelletTemplate")
    
    while (true) do
        wait(object.netTable.dropInterval - (.25 * object.netTable.dropNumber) )
        if (spawner.renderer.visible == true) then
            print(object.netTable.dropInterval - (.25 * object.netTable.dropNumber))
            for i = 1,object.netTable.dropNumber do
                wait(.25)

                local collectorName = "Tycoon"..tycoonid.."CollectorTouch"
                local collector = GetObjectByName(collectorName)
                local collectorTextName = "Tycoon"..tycoonid.."CollectorText"
                local collectorText = GetObjectByName(collectorTextName)
                collector.netTable.moneyInStorage = collector.netTable.moneyInStorage + object.netTable.dropValue 
                collectorText.worldText.text = collector.netTable.moneyInStorage.."$"
                
                --[[
                local drop = DuplicateObject(template)
                drop.netTable.Value = object.netTable.dropValue
                drop.renderer.color = Color.New(0/255,205/255,205/255)
                drop.name = "Tycoon".. tycoonid.."Pellet"
                drop.netTable.tycoonid = tycoonid
                drop.netTable["tycoonLevel"] = 1
                drop.position = spawner.position
                ]]
            end
        end
    end
end