local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Dungeon Egg! The code for this egg is: ''9kQB''. Let's not jump down this creepy hole, okay?")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end