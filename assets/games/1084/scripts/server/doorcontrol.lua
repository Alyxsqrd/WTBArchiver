local door = GetObjectByName("Bedroom_main_door")

function OnTouchBegin()
    door.position = door.position + Vector3.New(0, 7, 0)
    wait(5)
    CloseDoor()
end

function CloseDoor()
    door.position = door.position - Vector3.New(0, 7, 0)
end
