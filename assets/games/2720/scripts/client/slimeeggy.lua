local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Slimedrop Egg! The code for this egg is: ''k8JK''. Did you think it was a fruit? I certainly did!")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end