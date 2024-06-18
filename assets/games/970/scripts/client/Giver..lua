local script = PartByName("SCRIPT BLOCK")

function StartCollision(other)
	if IsHost and other.type == "Player" then
		script.scripts[1].Call("GrantAdmin", other)
	end
end