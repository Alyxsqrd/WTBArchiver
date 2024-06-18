function Begin()
    --wait(10.0)
    this.RunOnServer("CreateBricks")
end

-----------------------------------------------------
_G["objects"] = {}

VoxelObject = {}

function VoxelObject:New(w, h, d, voxels, pos, rot)
    o = {}
    setmetatable(o, self)
    self.__index = self
    
    o.w = w
    o.h = h
    o.d = d

    o.pivot = CreatePremade("Pivot")

    if pos ~= nil then
        o.pivot.position = pos
    end
    if rot ~= nil then
        o.pivot.rotation = rot
    end

    _G["objects"][o.pivot.id] = o

    o.id_to_ijk={}

    if voxels == nil then
        o.voxels = {}
        for i=1,w do
            o.voxels[i] = {}
            for j=1,h do
                o.voxels[i][j] = {}
                for k=1,d do
                    o.voxels[i][j][k] = CreatePremade("Brick")
                    o.id_to_ijk[o.voxels[i][j][k].id]={i, j, k}
                    o.voxels[i][j][k].position = Vector3.New(i, j, k)
                    o.voxels[i][j][k].SetParent(o.pivot)
                    --o.voxels[i][j][k].AddScript("new2")
                end
            end
        end
    else
        o.voxels = {}
        for i=1,w do
            o.voxels[i] = {}
            for j=1,h do
                o.voxels[i][j] = {}
                for k=1,d do
                    if voxels[i][j][k] ~= nil then
                        o.voxels[i][j][k] = voxels[i][j][k]
                        o.id_to_ijk[o.voxels[i][j][k].id]={i, j, k}
                        o.voxels[i][j][k].SetParent(o.pivot)
                    end
                end
            end
        end

--[[ 
        o.voxels = {}
        for i=1,w do
            o.voxels[i] = {}
            for j=1,h do
                o.voxels[i][j] = {}
                for k=1,d do
                    if voxels[i][j][k] ~= nil then
                        o.voxels[i][j][k] = CreatePremade("Brick")
                        o.id_to_ijk[o.voxels[i][j][k].id]={i, j, k}
            
                        o.voxels[i][j][k].position = voxels[i][j][k][1]
                        o.voxels[i][j][k].rotation = voxels[i][j][k][2]
                        o.voxels[i][j][k].SetParent(o.pivot)
                    end
                end
            end
        end
 ]]
    end



    
    return o
end


---------------------------------------------------------------------------------
function CreateBricks()

    local all_obj = GetAllObjects()
    for i,o in pairs(all_obj) do
        if (o.name == "Pivot") then
            --print(o.name)
            local blocks = o.GetAllChildren()
            for i2,block in pairs(blocks) do
                print(block.name)
            end 
        end
    end




--[[ 
    new_voxel_obj = VoxelObject:New(22, 1, 20)
    new_voxel_obj.pivot.MoveTo(Vector3.New(-1, 0, -40), 0.01)

    new_voxel_obj = VoxelObject:New(1, 10, 20)
    new_voxel_obj.pivot.MoveTo(Vector3.New(20, 1, -40), 0.01)

    new_voxel_obj = VoxelObject:New(20, 10, 1)
    new_voxel_obj.pivot.MoveTo(Vector3.New(0, 1, -40), 0.01)

    new_voxel_obj = VoxelObject:New(1, 10, 20)
    new_voxel_obj.pivot.MoveTo(Vector3.New(-1, 1, -40), 0.01)

    new_voxel_obj = VoxelObject:New(20, 10, 1)
    new_voxel_obj.pivot.MoveTo(Vector3.New(0, 1, -21), 0.01) 
]]

--[[ 
    wait(10.0)



    new_voxel_obj = VoxelObject:New(22, 1, 20)
    new_voxel_obj.pivot.MoveTo(Vector3.New(-1, 0, 20), 0.01)

    new_voxel_obj = VoxelObject:New(1, 10, 20)
    new_voxel_obj.pivot.MoveTo(Vector3.New(20, 1, 20), 0.01)

    new_voxel_obj = VoxelObject:New(20, 10, 1)
    new_voxel_obj.pivot.MoveTo(Vector3.New(0, 1, 20), 0.01)

    new_voxel_obj = VoxelObject:New(1, 10, 20)
    new_voxel_obj.pivot.MoveTo(Vector3.New(-1, 1, 20), 0.01)

    new_voxel_obj = VoxelObject:New(20, 10, 1)
    new_voxel_obj.pivot.MoveTo(Vector3.New(0, 1, 39), 0.01)
 ]]




    --new_voxel_obj.pivot.position = Vector3.New(-15, 0, 10)

    --new_voxel_obj:Remove()

    
--[[     pivot = CreatePremade("Pivot")
    pivot2 = CreatePremade("Pivot")

    voxel1 = CreatePremade("Brick")
    voxel2 = CreatePremade("Brick")
    voxel3 = CreatePremade("Brick")
    voxel4 = CreatePremade("Brick")

    voxel1.position = Vector3.New(1, 1, 1)
    voxel2.position = Vector3.New(2, 1, 1)
    voxel3.position = Vector3.New(4, 1, 1)
    voxel4.position = Vector3.New(5, 1, 1)

    voxel1.SetParent(pivot)
    voxel2.SetParent(pivot)
    voxel3.SetParent(pivot)
    voxel4.SetParent(pivot)

    wait(5)

    voxel1.SetParent(pivot2)
    voxel2.SetParent(pivot2)


    wait(5)
    --pivot.Delete() ]]

    --timer("CheckSeparatedAreasTimer", 1.0)
end
--[[ 
prev_is_finished = 1
function CheckSeparatedAreasTimer()
    if prev_is_finished == 1 then
        prev_is_finished = 0
        print("in timer")
        local list_to_check = {}
        for id, o in pairs(_G["objects"]) do
            table.insert(list_to_check, o)
        end
        for id, o in pairs(list_to_check) do
            --o:CheckSeparatedAreas()
        end

        prev_is_finished = 1
        timer("CheckSeparatedAreasTimer", 2.0)
    end
end
 ]]
last_time = 0
function Tick()
    if Input.LeftMouseHeld() then
        if Time.time - last_time > 0.1 then
            last_time = Time.time
            this.RunOnServer("CreateProjectile")
        end
    end

    if Input.MiddleMouseHeld() then
        local near_obj = RayCast(GetLocalPlayer().character.position, GetLocalPlayer().character.cameraDirection, 100.0)
        if near_obj.hitWildcard ~= nil and (near_obj.hitWildcard.name == "Brick" or near_obj.hitWildcard.name == "BrickSeparate"  or near_obj.hitWildcard.name == "Projectile") then
            local piv = near_obj.hitWildcard.parent or near_obj.hitWildcard
            piv.physics.AddForce(Vector3.New(0.0, 100.0, 0.0))
            print("force")
        end
    end

    if Input.RightMouseHeld() then

        local testVariable = GetLocalPlayer().character.HasItemEquipped("Block1")
        if testVariable == true then
            print("eqipped")
        end

        local near_obj = RayCast(GetLocalPlayer().character.position, GetLocalPlayer().character.cameraDirection, 100.0)

        if near_obj.hitWildcard ~= nil and near_obj.hitWildcard.name == "Brick" then
            --print("name: "..near_obj.hitWildcard.name)
            local i = _G["objects"][near_obj.hitWildcard.parent.id].id_to_ijk[near_obj.hitWildcard.id][1]
            local j = _G["objects"][near_obj.hitWildcard.parent.id].id_to_ijk[near_obj.hitWildcard.id][2]
            local k = _G["objects"][near_obj.hitWildcard.parent.id].id_to_ijk[near_obj.hitWildcard.id][3]

            local piv = near_obj.hitWildcard.parent
            _G["objects"][piv.id].voxels[i][j][k] = nil
            near_obj.hitWildcard.Delete()

            _G["objects"][piv.id]:CheckSeparatedAreas()
            piv.physics.AddForce(Vector3.New(0.0, 0.0, 0.1))
            --piv.physics.enabled = true
            --print("test message")
        else
            --print("null")
        end
    end 
end

function CreateProjectile()
    local new_projectile = CreatePremade("Projectile")

    new_projectile.rotation = GetLocalPlayer().character.rotation

    if GetLocalPlayer().character.isFirstPerson then
        new_projectile.position = GetLocalPlayer().character.position + GetLocalPlayer().character.cameraDirection
        new_projectile.physics.AddForce(GetLocalPlayer().character.cameraDirection * 20)
    else
        new_projectile.position = GetLocalPlayer().character.position + GetLocalPlayer().character.forwardDirection
        new_projectile.physics.AddForce(GetLocalPlayer().character.forwardDirection * 20)
    end


    --print(GetLocalPlayer().character.cameraZoom)
    --print(GetLocalPlayer().character.isFirstPerson)
end

function TouchProjectileBrick(touched, object)
    if touched ~= nil and IsObject(touched) and not IsCharacter(touched) and touched.name == "Brick" and touched.parent ~= nil and _G["objects"][touched.parent.id] ~= nil then
        local pos = touched.position
        local rot = touched.rotation
        
        local i = _G["objects"][touched.parent.id].id_to_ijk[touched.id][1]
        local j = _G["objects"][touched.parent.id].id_to_ijk[touched.id][2]
        local k = _G["objects"][touched.parent.id].id_to_ijk[touched.id][3]

        local par_id = touched.parent.id
        --print("parent_id: "..par_id)
        _G["objects"][touched.parent.id].voxels[i][j][k] = nil

        --spawn(_G["objects"][touched.parent.id].CheckSeparatedAreas, _G["objects"][touched.parent.id])
        _G["objects"][touched.parent.id]:CheckSeparatedAreas()
        --GetObjectByName("Empty2").GetScriptByName("new3").RunOnServer("CheckSeparatedAreas", _G["objects"][touched.parent.id])
        --this.Run("CheckSeparatedAreas", _G["objects"][touched.parent.id])
        

        touched.Delete()
------------------------------------------------------------------------------------------
        --object.Delete()
------------------------------------------------------------------------------------------
        local new_block = CreatePremade("BrickSeparate")
        new_block.position = pos
        new_block.rotation = rot
        --new_block.AddComponent("Physics")

        new_block.physics.AddExplosionForce(pos, 10.0, 5.0)
    end
end

function DFS(voxels, i, j, k, w, h, d, visited, voxels_array, voxels_arr_i)
    --print("DFS")
    if i < 1 or i > w or j < 1 or j > h or k < 1 or k > d then
        return
    end

    if voxels[i][j][k] == nil or visited[i][j][k] ~= nil then
        return
    end

    visited[i][j][k] = true

    --pos = voxels[i][j][k].position
    --rot = voxels[i][j][k].rotation
    --voxels_array[i][j][k] = { pos, rot }

    if voxels_arr_i > 1 then
        voxels_array[i][j][k] = voxels[i][j][k]
        voxels[i][j][k] = nil
    end

    DFS(voxels, i + 1, j, k, w, h, d, visited, voxels_array, voxels_arr_i)
    DFS(voxels, i - 1, j, k, w, h, d, visited, voxels_array, voxels_arr_i)
    DFS(voxels, i, j + 1, k, w, h, d, visited, voxels_array, voxels_arr_i)
    DFS(voxels, i, j - 1, k, w, h, d, visited, voxels_array, voxels_arr_i)
    DFS(voxels, i, j, k + 1, w, h, d, visited, voxels_array, voxels_arr_i)
    DFS(voxels, i, j, k - 1, w, h, d, visited, voxels_array, voxels_arr_i)
end

max_w = 100
max_h = 100
max_d = 100

max_voxel_arrays = 100

visited = {}
for i=1, max_w do
    visited[i] = {}
    for j=1, max_h do
        visited[i][j] = {}
    end
end

voxels_arrays = {}
for voxels_arr_i=1, max_voxel_arrays do
    voxels_arrays[voxels_arr_i] = {}
    for l=1,max_w do
        voxels_arrays[voxels_arr_i][l] = {}
        for m=1,max_h do
            voxels_arrays[voxels_arr_i][l][m] = {}
        end
    end 
end



function VoxelObject:CheckSeparatedAreas()
    --print("CheckSeparatedAreas: "..self.w.." "..self.h.." "..self.d)

        local voxels_arr_i = 1
        for i=1, self.w do
            for j=1, self.h do
                for k=1, self.d do
                    if self.voxels[i][j][k] ~= nil and visited[i][j][k] == nil then

                        DFS(self.voxels, i, j, k, self.w, self.h, self.d, visited, voxels_arrays[voxels_arr_i], voxels_arr_i)

                        voxels_arr_i = voxels_arr_i + 1
                    end
                end
            end
        end
        if voxels_arr_i - 1 > 1 then
            --print("Separation is needed: "..voxels_arr_i - 1)
            for voxels_arr_i2=2, voxels_arr_i - 1 do

                new_voxel_obj = VoxelObject:New(self.w, self.h, self.d, voxels_arrays[voxels_arr_i2], self.pivot.position, self.pivot.rotation)

                local rnd_color = Color.New(Random.Number(0.0, 1.0), Random.Number(0.0, 1.0), Random.Number(0.0, 1.0))
                for i=1, new_voxel_obj.w do
                    for j=1, new_voxel_obj.h do
                        for k=1, new_voxel_obj.d do
                            if new_voxel_obj.voxels[i][j][k] ~= nil then
                                --new_voxel_obj.voxels[i][j][k].blockRenderer.color = Color.New(1, voxels_arr_i2 - 1, 0)
                                new_voxel_obj.voxels[i][j][k].blockRenderer.color = rnd_color
                            end
                        end
                    end
                end
                 --print("separated "..voxels_arr_i2)
            end
            --self:Remove()
        else
            --print("arrays count: "..#voxels_arrays)
            --print("Nothing to separate")
        end

        for i=1, self.w do
            for j=1, self.h do
                for k=1, self.d do
                    visited[i][j][k] = nil
                end
            end
        end

        for voxels_arr_i2=1, voxels_arr_i - 1 do
            for l=1,self.w do
                for m=1,self.h do
                    for n=1,self.d do
                        voxels_arrays[voxels_arr_i2][l][m][n] = nil
                    end
                end
            end 
        end
end

function VoxelObject:Remove()
    for i=1, self.w do
        for j=1, self.h do
            for k=1, self.d do
                if self.voxels[i][j][k] ~= nil then
                    self.voxels[i][j][k].Delete()
                    self.voxels[i][j][k] = nil
                end
            end
        end
    end

    _G["objects"][self.pivot.id] = nil
    self.pivot.Delete()
end
