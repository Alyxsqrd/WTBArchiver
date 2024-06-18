local door = PartByName("md1")

function StartCollision()
    door.position = newVector3(-4.360394, 31.45496, -70.18709)

    CreateTimer("doorclose", 5)
end

function TimerEnd(name)
    if name == "doorclose" then
        door.position = door.position - newVector3(0, 7, 0)
    end
end
