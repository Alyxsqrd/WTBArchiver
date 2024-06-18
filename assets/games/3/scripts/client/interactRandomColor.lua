

function OnInteracted(character)
    if (isHost) then
        object.renderer.color = Random.Color()
    end
end

function OnTouchBegin(wildcard)
    if (isHost) then
        object.renderer.color = Random.Color()
    end
end