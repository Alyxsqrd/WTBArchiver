function OnInteracted(character)
object.voxelRenderer.visible = false
object.collider.enabled = false
object.sound.Play()
object.interactable.enabled = false
end