local door = PartByName("md4")

function StartCollision()
    door.position = newVector3(-59.77149, 30.94869, -438.1616)

    CreateTimer("doorclose", 5)
end

function TimerEnd(name)
    if name == "doorclose" then
        door.position = door.position - newVector3(0, 7, 0)
    end
end
