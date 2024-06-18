local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the White Egg! The code for this egg is: ''x4Wu''. It's a miracle it wasnt seriously damaged in the explosion!")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end