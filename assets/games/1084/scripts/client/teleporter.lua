local object = GetObjectById(1392)
function OnTouchBegin(player)
    object.sound.Play()
    player.position = Vector3.New(-53.6082,22.6009,-69.0756)
end