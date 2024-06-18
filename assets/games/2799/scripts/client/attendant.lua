function OnInteracted(character)
character.speed = 0.0
character.jumps = 0
character.player.SendSystemChat("ATTENDANT: Welcome, user.")
wait(2)
character.player.SendSystemChat("You: I would like to stay in a room for the night.")
wait(4)
character.player.SendSystemChat("ATTENDANT: Certainly.")
wait(2)
character.player.SendSystemChat("ATTENDANT: We are nearly full, but lucky you, Room 21 is empty.")
wait(4)
character.player.SendSystemChat("You stand rooted to the spot. Room 21?")
wait(2)
character.player.SendSystemChat("You: Oh, yes. Uh, I was wondering, how much do I pay overnight?")
wait(3)
character.player.SendSystemChat("ATTENDANT: Nothing.")
wait(3)
character.player.SendSystemChat("You: Uh, okay. May I have the keys?")
wait(2)
character.player.SendSystemChat("ATTENDANT: You don't need keys. It's already unlocked.")
wait(1)
character.player.SendSystemChat("ATTENDANT: Enjoy your stay, user!")
object.interactable.Remove()
character.speed = 0.8
character.jumps = 1
end