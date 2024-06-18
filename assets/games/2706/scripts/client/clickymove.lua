function OnItemMouseDown()
local char = GetLocalCharacter()
char.gravityDirection = char.gravityDirection * -1
object.sound.PlayLocal()
end