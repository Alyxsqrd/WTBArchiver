local am = 100
local am = PartByName("full")
local tank = PartByName("coolant")

function Start()
        tank.size = newVector3(56.0002,19,88.00061)
        am.text.text = "%100"
end

function StartCollision()
        if am < 100 then
                local runnow = true
                CreateTimer("refill", 1)
        end
end

function EndCollision()
        local runnow = false
end

function TimerEnd(name)
        if am < 100 then
                if name == "refill" then
                        tank.size = tank.size + newVector3(,,)
                        am = am + 1
                        am.text.text = "%"am .. "full"
                end
        end
        if am < 100 then
                if runnow == true then
                        CreateTimer("Increase", 1)
                end
        end
end

function TimerEnd()
        if name == "unfill" then
                if am > 0
                        tank.size = tank.size + newVector3(,,)
                        am = am + -1
                        CreateTimer("unfill", 1)
                end
        end
end
