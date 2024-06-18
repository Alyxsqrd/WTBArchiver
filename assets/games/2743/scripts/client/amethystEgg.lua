function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Amethyst Egg! The code for this egg is: M2rG. This egg has a beautiful purple hue that's reminiscent of gemstones.")
end