

function OnInteracted(character)
    printScreen("Testing Voxel Renderer", 5)
    object.renderer.design = "Storage Container (Open)"
    object.renderer.tint = Color.red
    object.renderer.transparency = 0.5
    waitTick(2)
    if object.renderer.design == "Storage Container (Open)" then
        printScreen("Block Voxel test 1 successful", 5, Color.green)
    else
        printScreen("Block Voxel test 1 failed", 5, Color.red)
    end
    if object.renderer.tint == Color.red then
        printScreen("Block Voxel test 2 successful", 5, Color.green)
    else
        printScreen("Block Voxel test 2 failed", 5, Color.red)
    end
    if object.renderer.transparency == 0.5 then
        printScreen("Block Voxel test 3 successful", 5, Color.green)
    else
        printScreen("Block Voxel test 3 failed", 5, Color.red)
    end
end
