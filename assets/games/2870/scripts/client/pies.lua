function OnInteracted(character)
if appleLeaderstat.worldText.text == "30" then
object.blockRenderer.color = green
wait(1)
DeleteObject(object)
else
object.blockRenderer.color = red
wait(1)
object.blockRenderer.color = white
end
end