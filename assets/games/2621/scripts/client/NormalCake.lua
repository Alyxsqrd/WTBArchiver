function ColNormalCake()
    object.renderer.visible = false
    object.collider.enabled = false
end

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then 
        this.Run("ColNormalCake")
    end
end

function MovNormalCake()
    Object.MoveTo(Vector3.New(0,167, 1,8222, 7,7466), 1.0)
    wait(0,5)
    Object.MoveTo(Vector3.New(0,167, 1,7222, 7,7466), 1.0)
end 


