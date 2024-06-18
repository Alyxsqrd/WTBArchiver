local sun = PartByName("Sun")

local deltaTime = 0
function Update()
    deltaTime = deltaTime + Time.delta
    deltaTime = deltaTime % 360
    
    sun.angles = newVector3(deltaTime, 331, 0.99)

    -- print(deltaTime % 360)
end