function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Red Striped Egg! The code for this egg is: W9h2. This egg has a classic red color with white stripes that give it a bold look.")
end