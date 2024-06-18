local door = PartByName("md2")

function StartCollision()
    door.position = newVector3(-11.66667, 31.63028, 60.87247)

    CreateTimer("doorclose", 5)
end

function TimerEnd(name)
    if name == "doorclose" then
        door.position = door.position - newVector3(0, 7, 0)
    end
end
