function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Orange Egg! The code for this egg is: K9tL. This egg has a bright orange color that's sure to stand out.")
end