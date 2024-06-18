function OnInteracted(interactor)
  this.RunOnServer("Teleport", interactor)
end

function Teleport(character)
  character.position = Vector3.New(-142.2153, 8.613, -2.4252)
end