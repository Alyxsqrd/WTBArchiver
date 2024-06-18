function Begin()
  while true do
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(0.02)
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(8)
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(0.02)
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(2)
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(0.02)
     object.light.enabled = true
     wait(0.02)
     object.light.enabled = false
     wait(3)
     object.sound.Play()
     wait(5)
  end
end