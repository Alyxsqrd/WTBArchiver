local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Brown Egg! The code for this egg is: ''Jt8T''. Maybe I shouldn't have been so harsh on you, there's eggs down here!")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end