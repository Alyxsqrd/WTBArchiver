function OnInteracted(interactor)
  this.RunOnServer("Teleport", interactor)
end

function OnTouchBegin(wildcard)
  if IsCharacter(wildcard) then
    this.RunOnServer("Teleport", wildcard)
  end
end

function Teleport(character)
  character.position = GetObjectByName("lvl4").position
end