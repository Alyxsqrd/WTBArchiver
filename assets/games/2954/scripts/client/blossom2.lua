function OnInteracted(character)
  object.sound.Play()
  character.speed = 0.0
  character.jumps = 0
  object.interactable.Remove()
  character.player.SendSystemChat("Blossom: Inside this cave is the foundation of the Pagoda.")
  wait(4)
  character.player.SendSystemChat("Blossom: To get inside the Pagoda, you must obtain the Souls of the Pagoda Gate.")
  character.speed = 1.0
  character.jumps = 1
end
