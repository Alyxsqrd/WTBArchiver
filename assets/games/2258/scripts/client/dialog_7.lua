function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("[DIALOG] Oh, a great variety of things. Bears, elk, moose, coyotes, wolves and snakes. In fact, up north like where we are right now, panthers are sure to be lurking around on the treetops. So, traveler, if you intend to move on, journey carefully.")
end