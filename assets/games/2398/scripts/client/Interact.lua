local opened = false
local opening = false

function OnInteracted(character)
  if isHost and not opening then
    opening = true
    if opened then
      object.RotateAround(Vector3.New(object.position + (object.leftDirection * 2), Vector3.New(0, 1, 0), -135, 1)
      opened = false
    else
      object.RotateAround(Vector3.New(object.position + (object.leftDirection * 2), Vector3.New(0, 1, 0), 135, 1)
      opened = true
    end
  end
  wait(1)
  opening = false
end