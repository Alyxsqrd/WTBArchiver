function onPlayerJoin()
	local parent = script.parent
	parent.text = "Hello, Player!"
end 

game.players.playerAdded:connect(onPlayerJoin)