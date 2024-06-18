local originalPosition
local canSink = true


function Begin()
    originalPosition = object.position
end

function OnTouchBegin(wildcard)
    if (IsCharacter(wildcard)) then
        if canSink then
            branch("Sink", wildcard)
        end
    end
end

function Sink(character)
    canSink = false
    object.MoveTo(originalPosition + Vector3.New(0, -3, 0), 2)
    wait(3)
    canSink = true
    object.MoveTo(originalPosition, 6)
end