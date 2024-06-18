local newproperty = false


function Tick()
  if newproperty == false then
    if Input.KeyPressed("E") then
      newproperty = true
      object.sound.Play()
      object.voxelRenderer.design = "Steve"
      wait(2)
      object.voxelRenderer.design = "Henry"
      wait(0.2)
      newproperty = false
    end
  end
end