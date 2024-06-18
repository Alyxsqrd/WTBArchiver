

function OnTouchBegin(wildcard)
    print("test 1")
    if IsCharacter(wildcard) then
        print("Character touched door!")
        object.RotateAround(object.position - (object.rightDirection * (object.size.x / 2)), object.upDirection, 120, 3)
    else
        print("not a char!")
    end
end