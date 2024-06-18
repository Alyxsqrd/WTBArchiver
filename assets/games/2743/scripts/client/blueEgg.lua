function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster: You've found the Blue Egg! The code for this egg is: Wk2G. This egg has a classic blue color with a smooth texture that's pleasant to the touch.")
end