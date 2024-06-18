function Begin()
  while true do
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(0.02)
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(12)
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(0.02)
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(7)
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(0.02)
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(10)
     object.sound.Play()
     wait(9)
  end
end