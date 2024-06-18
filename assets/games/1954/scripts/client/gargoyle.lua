local centerPos
local completeColorHex = "#00FF00"
local notCompleteColorHex = "#FF0000"
local puzzleCompleted = false


function Begin()
    centerPos = GetObjectByName("GargoyleCenter").position

    object.light.color = Color.ColorFromHex(notCompleteColorHex)
    object.localTable["complete"] = false

    Event.Bind(this, "CompleteGargoylePuzzle")
end

function CompleteGargoylePuzzle()
    puzzleCompleted = true
end

function OnInteracted(character)
    local dir = Vector3.Direction(object.position, character.position)
    local dotForward = Vector3.Dot(object.forwardDirection, dir)
    local dotBack = Vector3.Dot(object.backDirection, dir)
    local dotRight = Vector3.Dot(object.rightDirection, dir)
    local dotLeft = Vector3.Dot(object.leftDirection, dir)

    local moveDir
    if (dotForward > Math.Max(dotBack, dotRight, dotLeft)) then
        moveDir = object.forwardDirection
    elseif (dotBack > Math.Max(dotForward, dotRight, dotLeft)) then
        moveDir = object.backDirection
    elseif (dotRight > Math.Max(dotForward, dotBack, dotLeft)) then
        moveDir = object.rightDirection
    elseif (dotLeft > Math.Max(dotForward, dotBack, dotRight)) then
        moveDir = object.leftDirection
    end

    local desiredPos = object.position - (moveDir * 4)

    if (desiredPos.x > centerPos.x + 18) then
        return
    elseif (desiredPos.x < centerPos.x - 18) then
        return
    elseif (desiredPos.z > centerPos.z + 18) then
        return
    elseif (desiredPos.z < centerPos.z - 18) then
        return
    end

    local objsInDesiredPos = GetObjectsInSphere(desiredPos, 2.5)
    local isComplete = false
    for i,v in pairs(objsInDesiredPos) do
        if (IsValid(v.GetScriptByName("gargoyle"))) then
            return
        end
        if (v.name == "GargoyleBlocker") then
            return
        end
        if (v.name == object.name) then
            isComplete = true
        end
    end

    object.sound.Play()
    wait(0.2)

    object.MoveTo(desiredPos, 0.7)

    if (isComplete == false) then
        object.light.color = Color.ColorFromHex(notCompleteColorHex)
        object.localTable["complete"] = false
    end

    wait(0.45)

    if (isComplete == true) then
        PlayOneShotAt(14, 1, 0.33, object.position, 100)
    end

    wait(0.45)

    if (isComplete == true) then
        object.light.color = Color.ColorFromHex(completeColorHex)
        object.localTable["complete"] = true
        
        CheckAllComplete()
    end
end

function CheckAllComplete()
    local xPlusGargoyle = GetObjectById(2766)
    local xMinusGargoyle = GetObjectById(2764)
    local zPlusGargoyle = GetObjectById(2656)
    local zMinusGargoyle = GetObjectById(2762)

    if (xPlusGargoyle.localTable["complete"] == false) then
        return
    end
    if (xMinusGargoyle.localTable["complete"] == false) then
        return
    end
    if (zPlusGargoyle.localTable["complete"] == false) then
        return
    end
    if (zMinusGargoyle.localTable["complete"] == false) then
        return
    end

    if not puzzleCompleted then
        Event.Broadcast("CompleteGargoylePuzzle")
        PlayOneShot(23, 0.5 , 0.25)
        PlayOneShot(79, 1, 1)
    end
end