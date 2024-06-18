function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SetSpeed", wildcard)
end
end
function SetSpeed(character)
character.speed = 3
end