function OnInteracted(interactor)
  this.RunOnServer("Teleport", interactor)
end

function Teleport(character)
  character.position = GetObjectByName("TeleportPoint").position
end