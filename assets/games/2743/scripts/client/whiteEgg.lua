function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the White Egg! The code for this egg is: x4Wu. This egg is known for its pristine white color and smooth surface.")
end