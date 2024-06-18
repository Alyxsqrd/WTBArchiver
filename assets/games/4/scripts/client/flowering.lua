

function Begin()
    while true do
        wait(2)
        if object.renderer.design == "tree_normal" then
            object.renderer.design = "tree_normal_flowering"
            object.renderer.shadows = false
        else
            object.voxelRenderer.design = "tree_normal"
            object.renderer.shadows = true
        end
    end
end