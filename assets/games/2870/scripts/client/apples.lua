function OnInteracted(character)
print('1')
this.RunOnServer("GrantItem", wildcard)
print('2')
appleLeaderstat.worldText.text = appleLeaderstat.worldText.text + 1
end

function GrantItem()
print('3')
GrantItemTo(object.name, GetLocalCharacter())
DeleteObject(object)
print('4')
end
door.lua:
local red = Color.ColorFromHex("#ff636b")
local green = Color.ColorFromHex("#45ff4b")
local white = Color.ColorFromHex("#ffffff")
local appleLeaderstat = GetObjectByName("CollectedApples")

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
