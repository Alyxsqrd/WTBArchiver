function OnInteracted(character)
  object.sound.Play()
  character.speed = 0.0
  character.jumps = 0
  object.interactable.Remove()
  character.player.SendSystemChat("Hello!")
  wait(2)
  character.player.SendSystemChat("Would you like to make your own ornament for WorldToBuild's Christmas tree?")
  wait(4)
  character.player.SendSystemChat("If you like,")
  wait(0.6)
  character.player.SendSystemChat("and if you haven't made one already,")
  wait(2)
  character.player.SendSystemChat("S!")
  wait(2)
  character.player.SendSystemChat("!")
  wait(2)
  character.player.SendSystemChat("")
  character.speed = 1.0
  character.jumps = 1
end