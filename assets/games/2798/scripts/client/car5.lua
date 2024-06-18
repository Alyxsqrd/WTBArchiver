function OnInteracted(character)
  while true do
    if Input.KeyHeld("W") then
        this.RunOnServer("SwitchGravity", GetLocalCharacter())
    end
  end
end

function SwitchGravity(character)
    object.physics.AddForce(Vector3.New(0, character.cameraDirection.Y * 800, 0))
end