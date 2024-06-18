function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Egg of the Treasured Amethyst Blossom! The code for this egg is: 7Gys. This egg has a unique design inspired by the beautiful amethyst blossom, and it's truly a treasure to behold!")
end