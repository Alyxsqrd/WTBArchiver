function OnInteracted(character)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.speed = 0.0
character.jumps = 0
player.SendSystemChat("ATTENDANT: Welcome, user.")
wait(2)
player.SendSystemChat("You: I would like to stay in a room for the night.")
wait(2)
player.SendSystemChat("ATTENDANT: Certainly.")
wait(0.5)
player.SendSystemChat("ATTENDANT: We are nearly full, but lucky you, Room 21 is empty.")
wait(0.5)
player.SendSystemChat("You stand rooted to the spot. Room 21?")
wait(1)
player.SendSystemChat("You: Oh, yes. Uh, I was wondering, how much do I pay overnight?")
wait(1)
player.SendSystemChat("ATTENDANT: Nothing.")
wait(0.5)
player.SendSystemChat("You: Okay. May I have the keys?")
wait(1.5)
player.SendSystemChat("ATTENDANT: You don't need keys. It's already unlocked.")
wait(0.8)
player.SendSystemChat("ATTENDANT: Enjoy your stay, user!")
character.speed = 0.8
character.jumps = 1
end