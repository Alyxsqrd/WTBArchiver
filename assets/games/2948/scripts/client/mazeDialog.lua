function OnInteracted(character)
  object.sound.Play()
  character.speed = 0.0
  character.jumps = 0
  character.player.SendSystemChat("Hello! It looks like you have selected the Merry Maze challenge.")
  wait(2)
  character.player.SendSystemChat("Try to find your way through this maze. Unlock doors with special keys, and try to complete the quest to unlock the legendary Vault!")
  wait(4)
  character.player.SendSystemChat("And, if you complete this challenge, you will win all kinds of beautiful accessories to wear on your character!")
  character.speed = 1.35
  character.jumps = 1
end