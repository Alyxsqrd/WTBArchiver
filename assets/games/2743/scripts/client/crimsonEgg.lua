function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Crimson Egg! The code for this egg is: e3Wv. This egg has a deep red color that's reminiscent of blooming flowers.")
end