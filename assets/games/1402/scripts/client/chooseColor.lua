

function OnMouseClick()
    GetObjectByName("Drawing").GetScriptByName("gameManager").Run("ChooseColor", object.renderer.color)
end

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        GetObjectByName("Drawing").GetScriptByName("gameManager").Run("ChooseColor", object.renderer.color)
    end
end