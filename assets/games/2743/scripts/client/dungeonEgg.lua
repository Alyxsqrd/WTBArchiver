function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Dungeon's Egg! The code for this egg is: 9kQB. This egg has a dark, mysterious look that's reminiscent of ancient dungeons.")
end