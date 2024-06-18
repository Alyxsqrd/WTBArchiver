local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Orange Spotted Egg! The code for this egg is: ''Jv3e''. You're lucky you found this one while falling down, it was pretty well hidden!")
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end