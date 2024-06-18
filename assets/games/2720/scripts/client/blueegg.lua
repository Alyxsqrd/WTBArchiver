local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Blue Egg! The code for this egg is: ''Wk2G''. Can we fry this one? I'm starting to get quite hungry.")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end