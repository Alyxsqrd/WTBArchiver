local door = GetObjectByName("BarnDoor")
local appleLeaderstat = GetObjectByName("CollectedApples")

function OnInteracted(character)
    local Player = GetLocalPlayer()
    if appleLeaderstat.worldText.text == "30" then
        wait(1)
        DeleteObject(door)
        Player.SendSystemChat("Applester: Amazing job, " .. Player.username .. "! Thank you so much for your help.")
        object.sound.PlayLocal()
    end
end