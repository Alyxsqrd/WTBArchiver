function OnInteracted(character)
  object.sound.Play()
  character.speed = 0.0
  character.jumps = 0
  object.interactable.Remove()
  character.player.SendSystemChat("Blossom: This is the foundation on which the Pagoda stands.")
  wait(4)
  character.player.SendSystemChat("Blossom: The door is locked.")
  wait(4)
  character.player.SendSystemChat("Blossom: The Pagoda Gate can only be unlocked by obtaining the ???")
  character.speed = 1.0
  character.jumps = 1
end
