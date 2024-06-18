local wish = false


function Begin()
    Event.Bind(this, "MadeWish")
end

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        if not wish then
            GetLocalPlayer().SendSystemChat("[A voice says with a sinister chuckle: 'You haven't made your wish yet.']")
        end
    end
end

function MadeWish()
    wish = true
    object.collider.enabled = false
end