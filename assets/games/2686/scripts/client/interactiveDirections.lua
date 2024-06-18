function OnInteracted(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Go to the west cliff.")
wait(2)
character.player.SendSystemChat("Search for a mushroom.")
wait(2)
character.player.SendSystemChat("When you have found it, search carefully for a tiny hole in the west cliff rocks.")
wait(3)
character.player.SendSystemChat("Use the rule of nature, that usually - not always - things that are colorful can be dangerous, when looking for mushrooms.")
wait(4)
character.player.SendSystemChat("The mushroom lasts 1 minute.")
end