function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
      RunOnServer("Teleport", wildcard)
    end
  end
  
  function Teleport(character)
    character.position = Vector3.New(-53.6082,22.6009,-69.0756)
  end