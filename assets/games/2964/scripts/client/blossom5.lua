function OnInteracted(character)
  object.sound.Play()
  character.speed = 0.0
  character.jumps = 0
  object.interactable.Remove()
  character.player.SendSystemChat("Blossom: The key to unlock the Soul Gate is written on the hallway walls.")
  wait(2)
  character.speed = 1.0
  character.jumps = 1
end
