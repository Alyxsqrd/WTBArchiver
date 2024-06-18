local touch = 1 -- use 1 to represent touch not occurred yet
local Player = GetLocalPlayer()

function OnTouchBegin(wildcard)
	if IsCharacter(wildcard) and touch == 1 then -- check if the touch hasn't occurred yet
		object.sound.PlayLocal()
	    Player.SendSystemChat("Eggster: Hold on, " .. Player.username .. "! You shouldn't be down here, it's dangerous.")	
		touch = 0 -- set touch to 0 to indicate it has occurred
	end
end