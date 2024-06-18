

function OnInteracted(character)
    printScreen("Testing Light", 5)
    object.light.color = Color.blue
    object.light.type = "Spot"
    object.light.spotlightAngle = 90
    object.light.brightness = 2
    object.light.range = 20
    object.light.shadows = false
    waitTick(2)
    if object.light.color == Color.blue then
        printScreen("Light test 1 successful", 5, Color.green)
    else
        printScreen("Light test 1 failed", 5, Color.red)
    end
    if object.light.type == "Spot" then
        printScreen("Light test 2 successful", 5, Color.green)
    else
        printScreen("Light test 2 failed", 5, Color.red)
    end
    if object.light.spotlightAngle == 90 then
        printScreen("Light test 3 successful", 5, Color.green)
    else
        printScreen("Light test 3 failed", 5, Color.red)
    end
    if object.light.brightness == 2 then
        printScreen("Light test 4 successful", 5, Color.green)
    else
        printScreen("Light test 4 failed", 5, Color.red)
    end
    if object.light.range == 20 then
        printScreen("Light test 5 successful", 5, Color.green)
    else
        printScreen("Light test 5 failed", 5, Color.red)
    end
    if object.light.shadows == false then
        printScreen("Light test 6 successful", 5, Color.green)
    else
        printScreen("Light test 6 failed", 5, Color.red)
    end
end
