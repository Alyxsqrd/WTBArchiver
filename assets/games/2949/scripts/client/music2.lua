function Tick()
  if Input.KeyPressed("C") then
    object.sound.Play()
    print("Let the moosic begin..")
    wait(0.5)
    object.sound.id = 37
    object.sound.Play()
    wait(0.5)
    object.sound.id = 39
    object.sound.Play()
    wait(0.5)
    object.sound.id = 41
    object.sound.Play()
    wait(0.5)
    object.sound.id = 42
    object.sound.Play()
  end
end
