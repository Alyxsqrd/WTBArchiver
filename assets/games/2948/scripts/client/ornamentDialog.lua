function OnInteracted(character)
  object.sound.Play()
  character.speed = 0.0
  character.jumps = 0
  object.interactable.Remove()
  character.player.SendSystemChat("Hello!")
  wait(2)
  character.player.SendSystemChat("Would you like to make your own ornament to hang on WorldToBuild's Christmas tree?")
  wait(4)
  character.player.SendSystemChat("If so, you can submit them on the 2023 World to Build Christmas forum post.")
  character.speed = 1.35
  character.jumps = 1
end