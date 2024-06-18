function OnInteracted(character)
  object.voxelRenderer.visible = false
  object.collider.enabled = false
  object.sound.Play()
  object.interactable.enabled = false
  GetObjectByName("LockedDoor1").voxelRenderer.visible = false
  GetObjectByName("LockedDoor1").collider.enabled = false
  GetObjectByName("LockedDoor1").sound.Play()
  GetObjectByName("LockedDoor1").interactable.enabled = false
end