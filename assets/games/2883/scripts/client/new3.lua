function CheckSeparatedAreas(self)

    
    local visited = {}
    for i=1, self.w do
        visited[i] = {}
        for j=1, self.h do
            visited[i][j] = {}
        end
    end

    local voxels_arrays = {}
    local voxels_arr_i = 1

    for i=1, self.w do
        for j=1, self.h do
            for k=1, self.d do
                if self.voxels[i][j][k] ~= nil and visited[i][j][k] == nil then
                    voxels_arrays[voxels_arr_i] = {}
                    for l=1,self.w do
                        voxels_arrays[voxels_arr_i][l] = {}
                        for m=1,self.h do
                            voxels_arrays[voxels_arr_i][l][m] = {}
                        end
                    end

                    DFS(self.voxels, i, j, k, self.w, self.h, self.d, visited, voxels_arrays[voxels_arr_i])

                    voxels_arr_i = voxels_arr_i + 1
                end
            end
        end
    end
    
    if #voxels_arrays > 1 then
        --print("Separation is needed: "..#voxels_arrays)
        for voxels_arr_i=1, #voxels_arrays do

            new_voxel_obj = VoxelObject:New(self.w, self.h, self.d, voxels_arrays[voxels_arr_i], self.pivot.position, self.pivot.rotation)

            for i=1, new_voxel_obj.w do
                for j=1, new_voxel_obj.h do
                    for k=1, new_voxel_obj.d do
                        if new_voxel_obj.voxels[i][j][k] ~= nil then
                            new_voxel_obj.voxels[i][j][k].blockRenderer.color = Color.New(1, voxels_arr_i - 1, 0)
                        end
                    end
                end
            end
             --print("separated "..voxels_arr_i)
        end
        self:Remove()
    else
        --print("arrays count: "..#voxels_arrays)
        --print("Nothing to separate")
    end
end

function DFS(voxels, i, j, k, w, h, d, visited, voxels_array)
    if i < 1 or i > w or j < 1 or j > h or k < 1 or k > d then
        return
    end

    if voxels[i][j][k] == nil or visited[i][j][k] ~= nil then
        return
    end

    visited[i][j][k] = true

    pos = voxels[i][j][k].position
    rot = voxels[i][j][k].rotation

    voxels_array[i][j][k] = { pos, rot }

    DFS(voxels, i + 1, j, k, w, h, d, visited, voxels_array)
    DFS(voxels, i - 1, j, k, w, h, d, visited, voxels_array)
    DFS(voxels, i, j + 1, k, w, h, d, visited, voxels_array)
    DFS(voxels, i, j - 1, k, w, h, d, visited, voxels_array)
    DFS(voxels, i, j, k + 1, w, h, d, visited, voxels_array)
    DFS(voxels, i, j, k - 1, w, h, d, visited, voxels_array)
end