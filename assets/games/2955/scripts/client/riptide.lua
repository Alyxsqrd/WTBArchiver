

local speed = -40;


function Tick()
    if isHost then
        object.rotation = object.rotation + Vector3.New(0, speed * Time.deltaTime, 0)
    end
end