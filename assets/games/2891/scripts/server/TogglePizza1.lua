local PizzaSpot = GetObjectById(31)

function OnInteracted(character)
    PizzaSpot.voxelRenderer.visible = false
    PizzaSpot.collider.enabled = false
    wait(5)
    PizzaSpot.voxelRenderer.visible = true
    PizzaSpot.collider.enabled = true
 end