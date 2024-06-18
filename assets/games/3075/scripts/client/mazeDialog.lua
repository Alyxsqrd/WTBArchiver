function OnInteracted(character)
  object.sound.Play()
  character.speed = 0.0
  character.jumps = 0
  character.player.SendSystemChat("Hello! It looks like you have selected the Merry Maze challenge.")
  wait(2)
  character.player.SendSystemChat("And, if you complete this challenge, you will win DesignName to wear on your character!")
  character.speed = 1.0
  character.jumps = 1
end