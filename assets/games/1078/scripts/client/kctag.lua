local This = PartByName("tag")
local speed = 5
local teamtype = 0
function Start()
    if teamtype == 0 then
        print("orange")
    elseif teamtype == 1 then
        print("blue")
    end
end
function FixedUpdate()
    This.angles = This.angles + newVector3(0, speed, 0)
end
function StartCollision()
    This.Remove()
end
