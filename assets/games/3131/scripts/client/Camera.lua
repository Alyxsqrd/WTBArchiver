function OnCharacterSpawn(char)
    while true do
        object.rotation = Vector3.LookRotation(char.cameraDirection, Vector3.New(0,1,0))
        object.MoveTo((char.cameraPosition), 0.01)
        wait(0.1)
    end
end