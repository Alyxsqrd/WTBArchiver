local revealed = false


function Begin()
    Event.Bind(this, "RevealUpsideDown")
end

function RevealUpsideDown()
    revealed = true
end

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        wildcard.gravityPower = 0.25
    end
end