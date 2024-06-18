local round = true
local retard = false


function Tick()
  if round == true then
    if retard == false then
      if Input.KeyPressed("Z") then
        round = false
        print("I see the player you")
        wait(4)
        print("PLAYER?")
        wait(0.2)
        round = true
        retard = true
      end
    end
  end
end