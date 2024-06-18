local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Red Striped Egg! The code for this egg is: ''W9h2''. It must have landed perfectly on top of this tree after the explosion!")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end