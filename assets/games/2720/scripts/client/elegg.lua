local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Electric Egg! The code for this egg is: ''5Va4''. If this egg is truly electric, I wouldn't touch the water!")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end