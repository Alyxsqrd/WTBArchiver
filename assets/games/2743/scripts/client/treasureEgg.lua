function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Treasure Egg of Gems, K3hG! This egg is rumored to contain rare and valuable gems that can only be found on this island. Congratulations on your discovery!")
end