local text = GetObjectByName("GUI")
local char

function OnCharacterSpawn(character)
    char = GetLocalCharacter()
end

function LateTick()
    if (char ~= nil) then
        text.position = Vector3.new(char.cameraPosition.x, char.cameraPosition.y + 0.3, char.cameraPosition.z) + char.cameraDirection
    end
end