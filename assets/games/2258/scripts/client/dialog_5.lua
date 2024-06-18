function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("[DIALOG] You are in the Fictional Mountains, a mountain range that is far from any civilization. And I? I am a single hiker hiking among this part of the wilderness, and many times on my way I have encountered many dangers.")
end