function OnTouchBegin(Arg) -- // Arg is the thing that touched your object
    if IsCharacter(Arg) then -- // Check if the thing that we hit is a character
        object.MoveTo(Vector3.New(4, 100, 1), 60.0)
        --object.RotateTowards(Vector3.New(1, 1, 1), 1.0)
    end
end
function OnTouchContinue(Arg)
    if IsCharacter(Arg) then -- // Check if the thing that we hit is a character
        --object.MoveTo(Vector3.New(4, 100, 1), 60.0)
        object.RotateTowards(Vector3.New(100, 0, 0), 60.0)
    end
end