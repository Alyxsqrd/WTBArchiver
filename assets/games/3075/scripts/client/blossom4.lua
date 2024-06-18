function OnInteracted(character)
  object.sound.Play()
  character.speed = 0.0
  character.jumps = 0
  object.interactable.Remove()
  character.player.SendSystemChat("Blossom: The Souls of the Pagoda Gate are located in these two tunnels.")
  wait(2)
  character.player.SendSystemChat("Blossom: One soul is Magic, the other is Legendary.")
  wait(3)
  character.player.SendSystemChat("Blossom: You only need one.")
  character.speed = 1.0
  character.jumps = 1
end
