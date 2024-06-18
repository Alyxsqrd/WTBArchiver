local currentPlayer = LocalPlayer()

function Update()
	if InputPressed("left shift") then
		currentPlayer.speed = 14
	end

	if InputReleased("left shift") then
		currentPlayer.speed = 9
	end
end