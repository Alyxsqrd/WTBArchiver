function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("[DIALOG] Hello, traveler!")
wait(2)
character.player.SendSystemChat("[DIALOG] Hello, travelerss!")
end