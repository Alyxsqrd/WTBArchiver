

function Begin()
    Event.Bind(this, "RevealUpsideDown")
    Event.Bind(this, "CompleteRevealLampPuzzle")
end

function RevealUpsideDown()
    object.renderer.visible = true
    object.collider.enabled = true
end

function CompleteRevealLampPuzzle()
    object.renderer.visible = false
    object.collider.enabled = false
end