function OnInteracted(character)
  object.sound.Play()
  character.speed = 0.0
  character.jumps = 0
  object.interactable.Remove()
  character.player.SendSystemChat("Hello!")
  wait(2)
  character.player.SendSystemChat("What would you like this Christmas in World To Build?")
  wait(4)
  character.player.SendSystemChat("Write to Santa Claus by linking your design on the 2023 Christmas Event forum post. Thank you!")
  character.speed = 1.35
  character.jumps = 1
end