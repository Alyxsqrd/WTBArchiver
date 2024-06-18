

function OnInteracted(character)
    printScreen("Testing Block Renderer", 5)
    object.renderer.color = Color.green
    object.renderer.shadows = false
    object.renderer.transparency = 0.5
    object.renderer.visible = false
    waitTick(2)
    if object.renderer.color == Color.green then
        printScreen("Block Renderer test 1 successful", 5, Color.green)
    else
        printScreen("Block Renderer test 1 failed", 5, Color.red)
    end
    if object.renderer.shadows == false then
        printScreen("Block Renderer test 2 successful", 5, Color.green)
    else
        printScreen("Block Renderer test 2 failed", 5, Color.red)
    end
    if object.renderer.transparency == 0.5 then
        printScreen("Block Renderer test 3 successful", 5, Color.green)
    else
        printScreen("Block Renderer test 3 failed", 5, Color.red)
    end
    if object.renderer.visible == false then
        printScreen("Block Renderer test 4 successful", 5, Color.green)
    else
        printScreen("Block Renderer test 4 failed", 5, Color.red)
    end

    printScreen("Testing Collider", 5)
    object.collider.enabled = true
    object.collider.isTrigger = true
    object.collider.shape = "Sphere"
    waitTick(2)
    if object.collider.enabled == true then
        printScreen("Collider test 1 successful", 5, Color.green)
    else
        printScreen("Collider test 1 failed", 5, Color.red)
    end
    if object.collider.isTrigger == true then
        printScreen("Collider test 2 successful", 5, Color.green)
    else
        printScreen("Collider test 2 failed", 5, Color.red)
    end
    if object.collider.shape == "Sphere" then
        printScreen("Collider test 3 successful", 5, Color.green)
    else
        printScreen("Collider test 3 failed", 5, Color.red)
    end
end
