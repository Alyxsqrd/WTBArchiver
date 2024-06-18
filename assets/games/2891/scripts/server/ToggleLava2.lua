local LavaSpot = GetObjectById(172)

function OnInteracted(character)
    LavaSpot.blockRenderer.visible = true
    LavaSpot.GetScriptByName("KillScript").enabled = true
    wait(5)
    LavaSpot.blockRenderer.visible = false
    LavaSpot.GetScriptByName("KillScript").enabled = false
 end