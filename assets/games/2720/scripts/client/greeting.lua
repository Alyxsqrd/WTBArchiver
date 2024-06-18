function OnPlayerJoin(player)
	this.RunOnServer("SendChatMessage", player)
end

function SendChatMessage(character)
    character.player.SendSystemChat("Eggster: Can you hear me, " .. Player.username .. "? Good! You've been stranded on a remote island, and Easter is in jeopardy. Every egg is made in a factory on this island, but a group of mischievous rabbits caused an explosion, scattering the eggs far and wide. You need to collect them before Easter arrives!")
    wait(5)
    character.player.SendSystemChat("Eggster: We need your help to recover these precious eggs before it's too late! For every egg you find and return, I'll grant you a free copy to keep as a souvenir of your brave quest!")
    wait(5)
    character.player.SendSystemChat("Eggster: Time is of the essence. Let's get started. I'll be your guide. Are you ready, " .. Player.username .. "?")
end