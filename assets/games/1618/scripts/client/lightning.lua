function OnTouchBegin(wildcard)
  object.light.enabled = true
  wait(0.05)
  object.light.enabled = false
  wait(0.05)
  object.light.enabled = true
  wait(0.05)
  object.light.enabled = false
  wait(0.2)
  object.sound.Play()
end