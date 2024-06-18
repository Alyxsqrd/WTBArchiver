function Begin()
   character = GetLocalCharacter()
end

function OnInteracted(interactor)
  GetObjectById(242).GetScriptByName("GameDuper").Run("StartRainSpawning", nil)
  GetObjectById(242).GetScriptByName("GameDuper").Run("UnrecordRainSpawn", nil)
  this.RunOnServer("Teleport", interactor)
end

function Teleport(character)
  character.position = GetObjectByName("StartBlock").position
end