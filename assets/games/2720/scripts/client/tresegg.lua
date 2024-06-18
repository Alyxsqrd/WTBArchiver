local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Treasure Egg of Buildbux! The code for this egg is: ''f6Xs''. It seems this egg also contains 50 BuildBux! Spend it wisely.")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end