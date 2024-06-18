local open = false
local timeToOpen = 3


function Begin()
    Event.BindFunction(this, object.name, "OpenDoor")
    Event.BindFunction(this, object.name .. "Close", "CloseDoor")
end

function OpenDoor()
    if open then
        return
    end

    local rotatePoint = object.position + (object.rightDirection * (object.size.x / 2))
    if (IsValid(object.voxelRenderer) and object.voxelRenderer.design == "Purple Door") then
        rotatePoint = object.position + (object.rightDirection * 0.8)
    end

    object.RotateAround(rotatePoint, object.upDirection, -120, timeToOpen)

    wait(timeToOpen)

    open = true
end

function CloseDoor()
    if not open then
        return
    end

    local rotatePoint = object.position + (object.rightDirection * (object.size.x / 2))
    if (IsValid(object.voxelRenderer) and object.voxelRenderer.design == "Purple Door") then
        rotatePoint = object.position + (object.rightDirection * 0.8)
    end

    object.RotateAround(rotatePoint, object.upDirection, 120, timeToOpen)

    wait(timeToOpen)

    open = false
end