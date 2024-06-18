function Tick()
  if Input.KeyPressed("X") then
    object.sound.Play()
    print("Let the music commence.")
    wait(0.5)
    object.sound.pitch = 0.98
    object.sound.Play()
    wait(0.5)
    object.sound.pitch = 1.21
    object.sound.Play()
    wait(0.5)
    object.sound.pitch = 0.78
    object.sound.Play()
    wait(0.5)
    object.sound.pitch = 1.61
    object.sound.Play()
  end
end