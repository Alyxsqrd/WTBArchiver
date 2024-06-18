function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Yellow Egg! The code for this egg is: 8QfR. This egg has a sunny yellow color and a unique pattern that's sure to catch your eye.")
end