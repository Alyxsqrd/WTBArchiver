

function OnInteracted(character)
    printScreen("Testing Sound", 5)
    object.sound.id = 64
    object.sound.autoplay = false
    object.sound.looped = false
    object.sound.volume = 0.5
    object.sound.pitch = 0.5
    object.sound.global = true
    object.sound.radius = 200

    object.sound.Play()

    waitTick(2)
    if object.sound.id == 64 then
        printScreen("Sound test 1 successful", 5, Color.green)
    else
        printScreen("Sound test 1 failed", 5, Color.red)
    end
    if object.sound.autoplay == false then
        printScreen("Sound test 2 successful", 5, Color.green)
    else
        printScreen("Sound test 2 failed", 5, Color.red)
    end
    if object.sound.looped == false then
        printScreen("Sound test 3 successful", 5, Color.green)
    else
        printScreen("Sound test 3 failed", 5, Color.red)
    end
    if object.sound.volume == 0.5 then
        printScreen("Sound test 4 successful", 5, Color.green)
    else
        printScreen("Sound test 4 failed", 5, Color.red)
    end
    if object.sound.pitch == 0.5 then
        printScreen("Sound test 5 successful", 5, Color.green)
    else
        printScreen("Sound test 5 failed", 5, Color.red)
    end
    if object.sound.global == true then
        printScreen("Sound test 6 successful", 5, Color.green)
    else
        printScreen("Sound test 6 failed", 5, Color.red)
    end
    if object.sound.radius == 200 then
        printScreen("Sound test 7 successful", 5, Color.green)
    else
        printScreen("Sound test 7 failed", 5, Color.red)
    end
end
