

function OnMouseClick()
    if GetLocalPlayer().isHost then
        object.renderer.transparency = 50
        wait(2)
        object.RemoveComponent("renderer")
        wait(2)
        object.AddComponent("voxelRenderer")
        object.renderer.design = "Bookshelf"
        wait(2)
        object.RemoveComponent("voxelRenderer")
    end
end