function OnTouchBegin(wildcard)
  if IsCharacter(wildcard)
  then
    RunOnServer("OpenDoor")
  end
end

function OpenDoor()
  object.renderer.visible = false
  object.collider.enabled = false
  wait(2)
  object.renderer.visible = true
  object.collider.enabled = true
  end