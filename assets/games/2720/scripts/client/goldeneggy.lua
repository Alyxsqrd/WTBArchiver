local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Golden Egg! The code for this egg is: ''pN9A''. I really hope this one took you very long to find.")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end