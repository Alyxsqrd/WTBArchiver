function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Welcome to the Quest for Breakfast!")
wait(300)
character.player.SendSystemChat("You are getting hungry.")
end