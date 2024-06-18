local door = PartByName("brd")

function StartCollision()
    door.position = newVector3(-153.7361, 14.293526, -72.77377)

    CreateTimer("doorclose", 5)
end

function TimerEnd(name)
    if name == "doorclose" then
        door.position = door.position - newVector3(0, 7, 0)
    end
end
