local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Crimson Egg! The code for this egg is: ''e3Wv''. I was going to make a joke about you entering a crack to find this, but that's not PG-13.")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end