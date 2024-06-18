function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Orange Spotted Egg! The code for this egg is: Jv3e. This egg has a vibrant orange color with unique spots that give it a one-of-a-kind look.
")
end