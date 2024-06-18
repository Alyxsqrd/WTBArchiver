local build = 0
local create_block = nil
local character, dir, pos
function Begin()
    wait(1)

    character = GetLocalCharacter()

    dir = character.backDirection

    pos = (character.position + dir)

    print(pos)
    create_block = createBlock(pos, "create_block", 0, "0,0,0,0.2")
end 

function createBlock(positionvar, name, collide_val, colorval)
    --[[local findobj, newobj, obj_script
    findobj = GetObjectByName("copy_block")
    newobj = DuplicateObject(findobj)
    newobj.name = "CreatedPart"
    newobj.position = positionvar--]]
    -- position, name, collide
    local test = CreateEmptyObject()
    local new_x = math.floor(positionvar.x + 0.5)
    local new_y = math.max(math.floor(positionvar.y + 0.5), 2.0)
    local new_z = math.floor(positionvar.z + 0.5)
    local newlocation = Vector3.New(new_x, new_y, new_z)
    waitTick(1)
    test.name = name
    test.position = newlocation
    test.size = Vector3.New(1, 1, 1)
    test.AddComponent("Renderer")
    waitTick(1)
    local ren = test.renderer
    ren.visible = true

    local col1, col2, col3, cola

    if (colorval == nil) then 
        ren.color = Color.New(0, 0, 0, 1)
    else
        local new_col = mysplit(colorval, ",")
        for i,v in pairs(new_col) do

            if (i == 1) then
                col1 = tonumber(v)
            elseif (i == 2) then
                col2 = tonumber(v)
            elseif (i == 3) then
                col3 = tonumber(v)
            elseif (i == 4) then
                cola = tonumber(v)
            end
        end
        if cola ~= nil then
            local newcolor = Color.New(col1, col2, col3, cola)
            ren.color = Color.New(col1, col2, col3, cola)
        end
    end


    if (collide_val == 1) then
        test.AddComponent("collider")
        local collide = test.collider
        collide.shape = "Box"
    end

    return test


    
    
end

local function split_string(inputstr, sep)
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
        print(str)
    end
    return t

end

function Tick()
    if Input.LeftMousePressed() == true then
        build = 1
        waitTick(1)
    elseif Input.LeftMouseReleased() == true then
        build = 0
    end

    character = GetLocalCharacter()

    dir = character.backDirection

    pos = (character.position + dir)

    local new_x = math.floor(pos.x + 0.5)
    local new_y = math.max(math.floor(pos.y + 0.5), 2.0)
    local new_z = math.floor(pos.z + 0.5)
    local newlocation = Vector3.New(new_x, new_y, new_z)

    if (create_block ~= nil) then
        create_block.position = newlocation
    end

    if (build == 1) then
        waitTick(1)
        local raycast = RayCast(character.position, dir, 1)
        local test = "hey, ahesy, hey4, hey2"
        --local new_string = test:gsub("%^a", "")
        local test = mysplit(test, ",")

        --print(new_string)

        local pass = 0
        
        --local test = split_string(string(pos)), ", ")
        if (IsObject(raycast.hitWildcard) == false) then
            pass = 1
        elseif (IsObject(raycast.hitWildcard) == true) then
            if (raycast.hitWildcard.name == "create_block") then
                print("true")
                pass = 1
            end
            
        end

        if (pass == 1) then
            createBlock(pos, "Build_Block", 1, "50,100,25,1")
        end
    end


end

function mysplit(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end