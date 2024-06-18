local door = PartByName("md")

function StartCollision()
    door.position = newVector3(-64.95433, 31.45496, -67.80848)

    CreateTimer("doorclose", 5)
end

function TimerEnd(name)
    if name == "doorclose" then
        door.position = door.position - newVector3(0, 7, 0)
    end
end
