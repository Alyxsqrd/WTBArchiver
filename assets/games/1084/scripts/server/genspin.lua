local g1 = GetObjectById(1854)


local speed = 10

function LateTick()
    g1.rotation = g1.rotation + Vector3.New(5, 0, 0)
    
end