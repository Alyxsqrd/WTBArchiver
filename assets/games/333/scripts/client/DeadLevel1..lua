function StartCollision(other)
	if (other.type == "Player") then
		LocalPlayer().position = newVector3(0, 3, 32);
	end	
end

