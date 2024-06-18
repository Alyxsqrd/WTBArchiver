local touched = false


function Begin()
    Event.Bind(this, "CloseBalcony")
end

function OnTouchBegin(wildcard)
    if (IsCharacter(wildcard)) then
        touched = true
    end
end

function OnInvisible()
    if (touched) then
        local safeArea = GetObjectByName("ClosingPathwaySafeArea")
        local charsInBounds = GetCharactersInBounds(safeArea.position, safeArea.size + Vector3.New(0, 1000, 0))

        for i,v in pairs(charsInBounds) do
            if v == GetLocalCharacter() then
                Event.Broadcast("CloseBalcony")
                return
            end
        end
    end
end

function CloseBalcony()
    object.renderer.transparency = 0
    object.collider.isTrigger = false

    local part2 = GetObjectById(5700)
    part2.renderer.transparency = 0
    object.collider.isTrigger = false
end