function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Welcome to the Quest for Breakfast! Commence your journey, collect eggs, find alternate endings, and try to achieve the Legendary Dippy Egg! Credits: Derpware (Map, combining scripts) Tyster (Main complicated scripts).")
wait(300)
character.player.SendSystemChat("You are getting hungry.")
end