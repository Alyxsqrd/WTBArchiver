

local speed = 40;


function Tick()
    if isHost then
        object.rotation = object.rotation + Vector3.New(speed * Time.deltaTime, 0, 0)
    end
end

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        this.RunOnServer("KillCharacter", wildcard)
    end
end

function KillCharacter(character)
    character.Kill()
end