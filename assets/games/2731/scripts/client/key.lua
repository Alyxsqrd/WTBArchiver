function OnInteracted(character)
object.voxelRenderer.design = "Cleanwindow"
wait(5)
object.voxelRenderer.design = "Dirtywindow"
object.sound.Play()
end