function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Brown Egg! The code for this egg is: Jt8T. This egg is known for its earthy brown color and speckled texture.")
end