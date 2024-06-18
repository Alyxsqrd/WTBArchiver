function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Electric Egg! The code for this egg is: 5Va4. This egg has a bright blue color with a lightning bolt design that gives it an electrifying feel.")
end