function Tick()
    if Input.LeftMousePressed() then
        print("Click")
        this.RunOnServer("SpawnRocket", Input.mouseWorldPosition)
    end
end

function SpawnRocket(towards)
    local rocket = CreatePremade("Rocket")
    rocket.position = (object.position + object.forwardDirection*0.8 + object.upDirection*0.25)
    -- rocket.RotateTowards(towards, 0)
    -- rocket.physics.AddForce(Vector3.Direction(rocket.position, towards)*5)
    rocket.blockRenderer.visible = true
    -- PlayOneShotAt(9, 1.0, 1.0, object.position, 10.0)
    --rocket.AddScript("rocket")
ends