function OnTouchBegin(Arg)
	if IsCharacter(Arg) then
		Event.Broadcast("updateScore", 1)
		-- Event.BroadcastToServer("updateScore", 1)
	end
end
