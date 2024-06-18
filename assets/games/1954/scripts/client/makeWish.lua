local line1Part1 = "This time,"
local line1Part2 = " I want to REMEMBER"
local line1Part3 = " everything,"
local line2Part1 = " and leave" 
local line2Part2 = " this forsaken place"
local line2Part3 = " FOREVER."
local used = false


function OnInteracted(character)
    if used then
        return
    end
    used = true

    object.interactable.visible = false
    
    GetObjectByName("WishLine1Part1").worldText.text = line1Part1
    wait(1.5)
    GetObjectByName("WishLine1Part2").worldText.text = line1Part2
    wait(2)
    GetObjectByName("WishLine1Part3").worldText.text = line1Part3
    wait(0.75)

    GetObjectByName("WishLine2Part1").worldText.text = line2Part1
    wait(0.75)
    GetObjectByName("WishLine2Part2").worldText.text = line2Part2
    wait(1.5)
    GetObjectByName("WishLine2Part3").worldText.text = line2Part3
    wait(2)

    GetObjectByName("WishSignature").worldText.text = "- " .. GetLocalPlayer().nickname
    wait(0.1)

    Event.Broadcast("MadeWish")

    object.sound.Play()
    GetLocalPlayer().SendSystemChat("[A voice in the air whispers: 'You may leave.']")
end