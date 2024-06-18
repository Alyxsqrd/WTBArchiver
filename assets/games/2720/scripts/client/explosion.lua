local Player = GetLocalPlayer()

function OnInteracted(character)
	Player.SendSystemChat("Eggster: This is where the explosion happened! The factory was extremely small, because there was only 1 machine making all the Easter eggs for the entire world.")
	object.sound.PlayLocal()
end