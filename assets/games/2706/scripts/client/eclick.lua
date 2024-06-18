local uses = 1

function Begin()
	local character = GetLocalCharacter()
end

function Tick()
  if Input.KeyPressed("E") and uses == 1 then
    print("Test")
	local character = GetLocalCharacter()
	character.lockCameraZoom = false
    character.lockCameraMovement = false
    character.isFirstPerson = false
    character.frozen = false
	wait(0.1)
    uses = 0
  end
end

function Teleport(character)
	character.position = GetObjectByName("CutTP").position
end