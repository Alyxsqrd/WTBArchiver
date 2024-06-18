function OnCharacterSpawn(char) 
    local cube = CreateEmptyObject() waitTick(1) 
    cube.AddComponent("renderer")
    cube.AddComponent("collider")
    cube.AddComponent("physics") --toggle comment this line to cause it to error
    cube.position = char.position
    cube.renderer.color = Color.New(31/255, 128/255, 29/255, 0.1)
end