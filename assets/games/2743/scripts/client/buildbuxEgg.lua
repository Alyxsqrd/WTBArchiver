function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Treasure Egg of Buildbux with a code of f6Xs! This special egg contains 50 Buildbux, which will come in handy during your adventures. Keep it safe and spend them wisely!")
end