local moving = false


function OnInteracted(character)
    if moving then
        return
    end
    moving = true

    object.sound.Play()

    object.RotateAround(object.position + (object.rightDirection * 1), object.upDirection, 100, 1)
    wait(3)

    local mazeStart = GetObjectByName("InsideMazeStart")
    local charsInsideStart = GetCharactersInBounds(mazeStart.position, Vector3.New(mazeStart.size.x, 100, mazeStart.size.z))

    if #charsInsideStart > 0 then
        object.RotateAround(object.position + (object.rightDirection * 1), object.upDirection, -100, 0.2)
        wait(0.2)
    else
        object.RotateAround(object.position + (object.rightDirection * 1), object.upDirection, -100, 1)
        wait(1)
    end

    moving = false

    charsInsideStart = GetCharactersInBounds(mazeStart.position, Vector3.New(mazeStart.size.x, 100, mazeStart.size.z))
    if #charsInsideStart > 0 then
        GetLocalCharacter().position = GetLocalCharacter().position + Vector3.New(0, 105, 54)
        object.interactable.visible = false
    end
end