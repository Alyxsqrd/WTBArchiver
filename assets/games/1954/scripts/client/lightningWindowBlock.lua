

function Begin()
    Event.Bind(this, "LightningOn")
    Event.Bind(this, "LightningOff")
end

function LightningOn()
    object.blockRenderer.color = Color.ColorFromHex("#FFF7D4")
end

function LightningOff()
    object.blockRenderer.color = Color.ColorFromHex("#000000")
end