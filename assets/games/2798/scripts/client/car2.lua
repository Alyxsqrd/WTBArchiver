local rotating = false
local rotationSpeed = 1
local rotationAmount = 45

function Tick()
  if rotating == false then
    if Input.KeyPressed("E") then
      rotating = true
      object.RotateAround(object.position, object.upDirection, rotationAmount, rotationSpeed)
      wait(rotationSpeed)
      rotating = false
    end
    if Input.KeyPressed("Q") then
      rotating = true
      object.RotateAround(object.position, object.upDirection, -rotationAmount, rotationSpeed)
      wait(rotationSpeed)
      rotating = false
    end
  end
end