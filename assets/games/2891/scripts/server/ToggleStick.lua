local LavaSpot = GetObjectById(117)

function OnInteracted(character)
LavaSpot.blockRenderer.visible = false
    LavaSpot.collider.enabled = false
    wait(5)
    LavaSpot.blockRenderer.visible = true
    LavaSpot.collider.enabled = true
 end