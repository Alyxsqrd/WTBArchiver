function OnCharacterSpawn(character)
    character.lockCameraMovement = true
    character.lockCameraZoom = true
  end
  
  function Tick()
    for i,v in pairs(GetAllCharacters()) do
      v.cameraDirection = Vector3.New(1, 0, 0)
      v.cameraPosition = v.position + Vector3.New(10, 0, 0)
    end
  end