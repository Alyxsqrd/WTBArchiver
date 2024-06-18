

function Begin()
    Event.Bind(this, "LightningOn")
    Event.Bind(this, "LightningOff")
end

function LightningOn()
    object.voxelRenderer.design = "Outdoor Window Tall (Light)"
end

function LightningOff()
    object.voxelRenderer.design = "Outdoor Window Tall (Dark)"
end