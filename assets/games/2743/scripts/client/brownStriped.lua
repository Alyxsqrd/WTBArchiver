function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Brown Egg with Pink and Red Accents! The code for this egg is: Ns5y. This egg has a warm brown color with pink and red accents that give it a cozy feel.")
end