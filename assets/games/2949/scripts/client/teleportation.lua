local round = false


function Tick()
  if round == false then
    if Input.KeyPressed("Q") then
      round = true
      print("I see the player you mean.")
      wait(4)
      print("PLAYERNAME?")
      wait(0.2)
      round = false
    end
  end
end