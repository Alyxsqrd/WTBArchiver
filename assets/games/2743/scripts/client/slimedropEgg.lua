function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Slimedrop Egg! The code for this egg is: k8JK. This egg has a slimy green exterior and a droplet shape that's both unique and fun.")
end