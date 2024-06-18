local player = LocalPlayer()

--[[ local top = This.position.y + (This.size.y / 2) + 1
local bottom = This.position.y - (This.size.y / 2)

function Update()
	local distance = Vector3.Distance(newVector3(This.position.x, 0, This.position.z), newVector3(player.position.x, 0, player.position.z))

	if distance < 0.9 and player.position.y < top and player.position.y > bottom and InputHeld("w") then
		player.velocity = player.velocity + newVector3(0, 120 * Time.delta, 0)
	end
end ]]

function ContinueCollision(other)
	if other.type == "Player" and other.isLocal then
		player.velocity = player.velocity + newVector3(0, 120 * Time.delta, 0)
	end
end