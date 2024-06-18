local ggg = 0

function OnTouchBegin(wildcard)
    if ggg != 6 then
    if IsCharacter(wildcard) then
        ggg = 6
        object.MoveTo(Vector3.New(-72.5, -4, -163.5), 0.02)
        wait(0.03)
        object.MoveTo(Vector3.New(-72.5, -20, -163.5), 8.0)
    end
    end
end