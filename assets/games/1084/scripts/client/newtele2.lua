function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
      RunOnServer("Teleport", wildcard)
    end
  end
  
  function Teleport(character)
    character.position = Vector3.New(-65.8944,4.2701,-67.2584)
  end