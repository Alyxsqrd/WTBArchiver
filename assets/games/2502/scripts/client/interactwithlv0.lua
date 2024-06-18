function OnInteracted(interactor)
  this.RunOnServer("Teleport", interactor)
end

function Teleport(character)
  character.position = Vector3.New(-77.068, 7.6789, -1.3971)
end