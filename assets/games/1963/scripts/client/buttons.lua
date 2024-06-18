function Begin()
    speed = 1
end

function OnTouchBegin()
    local amount = 0

    if object.name == "RightButton" then
        amount = speed
    end
    if object.name == "LeftButton" then
        amount = -speed
    end
    if object.name == "ControllerPlatform" then
        amount = 0
    end

    Event.BroadcastToServer("startRotate",amount)
end