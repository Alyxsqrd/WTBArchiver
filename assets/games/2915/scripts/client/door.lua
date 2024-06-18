local red = Color.ColorFromHex("#ff636b")
local green = Color.ColorFromHex("#45ff4b")
local white = Color.ColorFromHex("#ffffff")
local appleLeaderstat = GetObjectByName("CollectedApples")

function OnInteracted(character)
    if appleLeaderstat.worldText.text == "2" then
        object.blockRenderer.color = green
        wait(1)
        DeleteObject(object)
    else
        object.blockRenderer.color = red
        wait(1)
        object.blockRenderer.color = white
    end
end