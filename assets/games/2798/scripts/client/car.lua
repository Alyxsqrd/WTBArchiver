function OnInteracted(character)
  while true do
    if Input.KeyHeld("W") then
        this.RunOnServer("SwitchGravity", GetLocalCharacter())
    end
  end
end

function SwitchGravity(character)
    object.physics.AddForce(character.cameraDirection * 800)
end