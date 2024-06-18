local pos = object.position
local ggg = 0

function OnTouchBegin(wildcard)
    if ggg != 6 then
    if IsCharacter(wildcard) then
        ggg = 6
        object.MoveTo(Vector3.New(pos.x, pos.y-10, pos.z), 5)
        wait(20.0)
        object.MoveTo(Vector3.New(pos.x, pos.y, pos.z), 5)
    end
    end
end