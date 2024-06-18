function Begin()
    dmg = 10
end

function OnTouchBegin(touched)
    if(IsCharacter(touched)) then
        --[[
        if(touched.health - dmg > 0) then
            touched.health = touched.health - dmg
        else
            touched.health = touched.maxHealth
            touched.position = Vector3.New(0,1,0)
        end
        ]]
        touched.health = touched.health - dmg
        DeleteObject(object)
    end
end