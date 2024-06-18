local casings 

function Tick()
    if Input.LeftMousePressed() then
        this.RunOnServer("Shoot", Input.mouseWorldPosition)
    end
end

function Shoot(towards)
    local casing = CreatePremade("casing")
    local ejectAngle = object.rightDirection*0.85 + object.upDirection*0.15
    casing.RotateTowards(object.forwardDirection, 0)
    casing.size = Vector3.new(0.02, 0.02, 0.02)
    casing.position = object.position + object.upDirection*0.3 + object.rightDirection*0.035 + object.forwardDirection*0.2
    casing.physics.AddForce(ejectAngle*2)
    Event.Broadcast("NewCasing", casing)
    PlayOneShotAt(9, 1.0, 3.2, object.position, 15.0)
end