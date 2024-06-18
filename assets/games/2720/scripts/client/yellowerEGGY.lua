local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Yellow Egg! The code for this egg is: ''8QfR''. This one almost looks like a sand castle!")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end