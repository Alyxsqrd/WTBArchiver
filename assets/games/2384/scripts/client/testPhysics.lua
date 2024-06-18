

function OnInteracted(character)
    printScreen("Testing Physics", 5)
    object.physics.enabled = true
    object.physics.autoMass = true
    object.physics.gravity = false
    
    waitTick(2)
    object.physics.AddForce(Vector3.New(0, 1000, 0))

    waitTick(2)
    if object.physics.enabled == true then
        printScreen("Physics test 1 successful", 5, Color.green)
    else
        printScreen("Physics test 1 failed", 5, Color.red)
    end
    if object.physics.autoMass == true then
        printScreen("Physics test 2 successful", 5, Color.green)
    else
        printScreen("Physics test 2 failed", 5, Color.red)
    end
    if object.physics.gravity == false then
        printScreen("Physics test 3 successful", 5, Color.green)
    else
        printScreen("Physics test 3 failed", 5, Color.red)
    end
    if object.physics.velocity.y > 0 then
        printScreen("Physics test 4 successful", 5, Color.green)
    else
        printScreen("Physics test 4 failed", 5, Color.red)
    end
end
