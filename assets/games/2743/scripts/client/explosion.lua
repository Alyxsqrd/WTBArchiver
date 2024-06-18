function OnInteracted(character)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster > This is where the explosion occured.")
wait(3)
character.player.SendSystemChat("Eggster > Most Easter eggs were scattered across the island.")
wait(5)
character.player.SendSystemChat("Eggster > Unfortunately, a few have been blown into the ocean, and cannot be recovered.")
end