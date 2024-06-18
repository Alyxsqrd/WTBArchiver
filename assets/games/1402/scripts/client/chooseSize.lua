

function OnMouseClick()
    GetObjectByName("Drawing").GetScriptByName("gameManager").Run("ChooseSize", object.size.y)
end

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        GetObjectByName("Drawing").GetScriptByName("gameManager").Run("ChooseSize", object.size.y)
    end
end