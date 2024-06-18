local door = GetObjectByName("BarnDoor")
local appleLeaderstat = GetObjectByName("CollectedApples")

function OnInteracted(character)
    if appleLeaderstat.worldText.text == "30" then
        wait(1)
        door.RotateAround(x, y, z)
    end
end