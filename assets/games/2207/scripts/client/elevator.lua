local moving = false


function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        this.RunOnServer("MoveUp")
    end
end

function MoveUp()
    if moving then -- if we're already moving, don't start moving again
        return -- return ends the function instantly
    end

    moving = true -- we're starting to move

    for i = 0, 10 do -- "for" loop that goes from 0 to 10
        object.position = object.position + Vector3.New(0, 0.25, 0)
        wait(0.2)
    end
    
    wait(2)

    for i = 0, 10 do
        object.position = object.position - Vector3.New(0, 0.25, 0)
        wait(0.2)
    end

    moving = false -- we're done moving
end