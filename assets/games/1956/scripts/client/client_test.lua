function Begin()
    print(this.scriptName)

end

local function createBlock(positionvar)
    local findobj, newobj, obj_script
    findobj = GetObjectByName("copy_block")
    newobj = DuplicateObject(findobj)
    newobj.name = "CreatedPart"
    newobj.position = positionvar

    --[[local test = CreateEmptyObject()
    waitTick(1)
    test.name = "Test"
    test.position = positionvar
    test.size = Vector3.New(1, 1, 1)

    test.AddComponent("Renderer")
    local ren = test.renderer
    ren.visible = true
    ren.color = Color.New(245, 203, 66, 1)

    test.AddComponent("collider")
    local collide = test.collider
    collide.shape = "Box"
    print(test.name .. " -- testasd")

    test.AddScript("new_block")
    local bl_scr = test.GetScriptByName("new_block")
    print(bl_scr.name)--]]
    
    
end

function Tick()
    if Input.KeyPressed("Space") == true then
        local test = GetLocalCharacter()
        local player_x, player_y, player_z
        --[[player_x = math.floor(test.position.x + 0.5)
        player_y = (math.floor(test.position.y + 0.5) - 1)`
        player_z = math.floor(test.position.z + 0.5)--]]
        player_x = math.floor(test.position.x + 0.5)
        player_y = (math.floor(test.position.y + 0.5) - 1)
        player_z = math.floor(test.position.z + 0.5)

        local new_table = Table.new()
        new_table[1] = tostring(player_x)
        new_table[2] = tostring(player_y)
        new_table[3] = tostring(player_z)

        object.NetMessagePlayer(GetHostPlayer(), new_table)
        
        --NetMessageAll(new_table)
        --createBlock(Vector3.new(player_x, player_y, player_z))
    end
end

function OnNetMessage(datavalue)
    if isHost then
        local player_x, player_y, player_z
        player_x = tonumber(datavalue[1])
        player_y = tonumber(datavalue[2])
        player_z = tonumber(datavalue[3])

        createBlock(Vector3.new(player_x, player_y, player_z))

    end
end