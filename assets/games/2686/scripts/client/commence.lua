function OnInteracted(interactor)
this.RunOnServer("Teleport", interactor)
end

function Teleport(character)
character.position = Vector3.New(1319.258, 66.4995, 45.881)
end