function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Golden Egg! The code for this egg is: pN9A. This egg is a true treasure, with a shiny gold surface that's sure to dazzle.")
end