local sprintSpeed = 1.5
local normalSpeed = 1

function Tick()
  if Input.KeyPressed("LeftShift") then
    local myPlayer = GetLocalPlayer()
    if IsValid(myPlayer) then
      myPlayer.character.speed = sprintSpeed 
    end
  end
  if Input.KeyReleased("LeftShift") then
    local myPlayer = GetLocalPlayer()
    if IsValid(myPlayer) then
      myPlayer.character.speed = normalSpeed 
    end
  end
end