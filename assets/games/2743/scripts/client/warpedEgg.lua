function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Brown Egg with Warped Accents! The code for this egg is: fG6L. This egg has a traditional brown color with warped accents that add a touch of whimsy.")
end