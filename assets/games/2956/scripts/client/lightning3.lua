function Begin()
  while true do
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(0.02)
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(7.5)
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(0.02)
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(10.3)
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(0.02)
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(6.5)
     object.sound.Play()
     wait(9.5)
  end
end