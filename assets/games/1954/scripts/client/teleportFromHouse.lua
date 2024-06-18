local secret = false


function Begin()
    Event.Bind(this, "CompleteRevealLampPuzzle")
end

function OnTouchBegin(wildcard)
    if (IsCharacter(wildcard)) then
        if not secret then
            local target = GetObjectByName("HouseTeleportOut")
            if (IsValid(target)) then
                wildcard.position = target.position
                wildcard.rotation = target.forwardDirection
            end
        else
            local secretTarget = GetObjectByName("SecretTeleport")
            if (IsValid(secretTarget)) then
                wildcard.position = secretTarget.position
                wildcard.rotation = secretTarget.forwardDirection
                wildcard.gravityDirection = Vector3.New(0, -1, 0)
            end
        end
    end
end

function CompleteRevealLampPuzzle()
    secret = true
end