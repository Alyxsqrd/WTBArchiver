

function OnInteracted(character)
    if (object.light.enabled) then
        object.light.enabled = false
        object.voxelRenderer.design = "Gargoyle Statue (Mossy)"
        GetObjectById(4090).worldText.enabled = false
    else
        object.light.enabled = true
        object.voxelRenderer.design = "Gargoyle Statue (Mossy) (Red Eyes)"
        object.sound.Play()
        GetObjectById(4090).worldText.enabled = true
    end
end