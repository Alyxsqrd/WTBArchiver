if IsCharacter(touched) then
  object.voxelRenderer.visible = false
  object.interactable.Remove()
  wait(2)
  touched.Damage(10)
  wait(0.6)
  character.speed = 0.6
  wait(2)
  touched.Damage(10)
  wait(2)
  touched.Damage(10)
  wait(3)
  touched.Damage(10)
  wait(2)
  touched.Damage(10)
  wait(5)
  touched.Damage(10)
end