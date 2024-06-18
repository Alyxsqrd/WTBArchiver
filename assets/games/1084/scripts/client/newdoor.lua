local open = false
local door = GetObjectByName("Bedroom_main_door")

function OnTouchBegin(wildcard)
  if IsCharacter(wildcard) then
    RunOnServer("OpenDoor")
  end
end

function OpenDoor()
  if open == false then
    open = true
    door.position = door.position + Vector3.New(0, 7, 0)
    wait(2)
    door.position = door.position - Vector3.New(0, 7, 0)
    open = false
  end
end