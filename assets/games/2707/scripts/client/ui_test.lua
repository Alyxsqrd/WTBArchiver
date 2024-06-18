function LateTick()
    local textobj = GetObjectById(11)
    local char = GetLocalCharacter()
    local cross = Vector3.Cross(char.cameraDirection, -char.cameraDirection)
    textobj.position = char.cameraPosition + char.cameraDirection*0.75 + cross*20
end