local door = PartByName("md3")

function StartCollision()
    door.position = newVector3(-24.14265, 31.03452, -100.9568)

    CreateTimer("doorclose", 5)
end

function TimerEnd(name)
    if name == "doorclose" then
        door.position = door.position - newVector3(0, 7, 0)
    end
end
