function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Teardrop Egg! The code for this egg is: W5uZ. This egg has a unique teardrop shape and a beautiful blue color.")
end