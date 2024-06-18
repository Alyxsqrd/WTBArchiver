local endLoop = false

function Begin()
  while true do
    object.worldText.text = ">"
    object.sound.PlayLocal()
    wait(0.75)
    
    object.sound.PlayLocal()
    object.worldText.text = " "
    wait(0.75)
  end
end
