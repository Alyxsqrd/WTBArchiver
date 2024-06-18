function OnInteracted(character)
  object.sound.Play()
  character.speed = 0.0
  character.jumps = 0
  object.interactable.Remove()
  character.player.SendSystemChat("Blossom: The souls of the Pagoda Gate are hiding in the cliff in this cave.")
  wait(4)
  character.player.SendSystemChat("Blossom: That is your key inside.")
  character.speed = 1.0
  character.jumps = 1
end
