local Player = GetLocalPlayer()

function Begin()
	print("Bug fixing print")
	local Character = GetLocalCharacter()
end

function OnPlayerJoin(player)
	wait(1)
	local Character = GetLocalCharacter()
	Character.frozen = true
	wait(3)
    Player.SendSystemChat("Eggster: Can you hear me, " .. Player.username .. "? Good! You've been stranded on a remote island, and Easter is in jeopardy. Every egg is made in a factory on this island, but a group of mischievous rabbits caused an explosion, scattering the eggs far and wide. You need to collect them before Easter arrives!")
	object.sound.PlayLocal()
    wait(7)
    Player.SendSystemChat("Eggster: We need your help to recover these precious eggs before it's too late! For every egg you find and return, I'll grant you a free copy to keep as a souvenir of your brave quest!")
	object.sound.PlayLocal()
    wait(5)
    Player.SendSystemChat("Eggster: Time is of the essence. Let's get started. I'll be your guide. Are you ready, " .. Player.username .. "?")
	object.sound.PlayLocal()
	wait(3)
    Player.SendSystemChat("Eggster: I'll take your silence as a resounding ''yes''! Once you find an egg, click on it to retrieve it. It may take a few clicks.")
	object.sound.PlayLocal()
	Character.frozen = false
end