function OnInteracted(character)
object.light.enabled = true
object.sound.Play()
object.interactable.enabled = false
wait(8)
object.light.enabled = false
object.interactable.enabled = true
end