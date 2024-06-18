

function Begin()
    Event.Bind(this, "RevealUpsideDown")
    Event.BindFunction(this, object.name, "Fall")
end

function RevealUpsideDown()
    object.light.color = Color.red
end

function Fall()
    object.physics.enabled = true
    object.light.enabled = false
end