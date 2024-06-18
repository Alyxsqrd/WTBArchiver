function OnInteracted(character)
  object.sound.Play()
  character.speed = 0.0
  character.jumps = 0
  object.interactable.Remove()
  character.player.SendSystemChat("Text1")
  wait(2)
  character.player.SendSystemChat("Text2")
  wait(2)
  character.player.SendSystemChat("Text3")
  wait(2)
  character.player.SendSystemChat("Text4")
  wait(2)
  character.player.SendSystemChat("Text5")
  wait(2)
  character.player.SendSystemChat("Text6")
  wait(2)
  character.player.SendSystemChat("Text7")
  character.speed = 1.0
  character.jumps = 1
end