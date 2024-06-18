

function OnInteracted(character)
    printScreen("Testing World Text", 5)
    object.worldText.text = "Win"
    object.worldText.size = 16
    object.worldText.font = "Bangers"
    object.worldText.alignment = "Left"
    object.worldText.faceCamera = true
    object.worldText.color = Color.red
    object.worldText.outlineColor = Color.blue
    object.worldText.outlineWidth = 2
    object.worldText.hideAtDistance = true
    object.worldText.hiddenDistance = 50
    waitTick(2)
    if object.worldText.text == "Win" then
        printScreen("World Text test 1 successful", 5, Color.green)
    else
        printScreen("World Text test 1 failed", 5, Color.red)
    end
    if object.worldText.size == 16 then
        printScreen("World Text test 2 successful", 5, Color.green)
    else
        printScreen("World Text test 2 failed", 5, Color.red)
    end
    if object.worldText.font == "Bangers" then
        printScreen("World Text test 3 successful", 5, Color.green)
    else
        printScreen("World Text test 3 failed", 5, Color.red)
    end
    if object.worldText.alignment == "Left" then
        printScreen("World Text test 4 successful", 5, Color.green)
    else
        printScreen("World Text test 4 failed", 5, Color.red)
    end
    if object.worldText.faceCamera == true then
        printScreen("World Text test 5 successful", 5, Color.green)
    else
        printScreen("World Text test 5 failed", 5, Color.red)
    end
    if object.worldText.color == Color.red then
        printScreen("World Text test 6 successful", 5, Color.green)
    else
        printScreen("World Text test 6 failed", 5, Color.red)
    end
    if object.worldText.outlineColor == Color.blue then
        printScreen("World Text test 7 successful", 5, Color.green)
    else
        printScreen("World Text test 7 failed", 5, Color.red)
    end
    if object.worldText.outlineWidth == 2 then
        printScreen("World Text test 8 successful", 5, Color.green)
    else
        printScreen("World Text test 8 failed", 5, Color.red)
    end
    if object.worldText.hideAtDistance == true then
        printScreen("World Text test 9 successful", 5, Color.green)
    else
        printScreen("World Text test 9 failed", 5, Color.red)
    end
    if object.worldText.hiddenDistance == 50 then
        printScreen("World Text test 10 successful", 5, Color.green)
    else
        printScreen("World Text test 10 failed", 5, Color.red)
    end
end
