

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        this.RunOnServer("Dupe")
    end
end

function Dupe()
    local d = object.Duplicate()
    d.position = d.position + Vector3.New(0, 0, -2)
end