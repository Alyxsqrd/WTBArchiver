function OnInteracted(character)
  object.sound.Play()
  character.speed = 0.0
  character.jumps = 0
  character.player.SendSystemChat("Hello! It looks like you have selected the Holiday Parkour challenge.")
  wait(2)
  character.player.SendSystemChat("If you complete this challenge, you will win all sorts of beautiful accessories to wear on your character!")
  character.speed = 1.35
  character.jumps = 1
end