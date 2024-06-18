function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Dippy Egg! The code for this egg is: eH3b. This egg has a whimsical design with colorful drips that give it a playful look.")
end