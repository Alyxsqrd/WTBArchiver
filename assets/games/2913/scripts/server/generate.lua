local SIZE = 36
local X = SIZE/2
local Z = SIZE/2
local SCALE = 1.18
local NOISELEVEL = Random.Number(6,10)

local i = 0
local v = 0
local g = 0
local grid = Table.New()

-- Init... generate ground terrain
function Begin()

for x = 1, X do
    grid[x] = Table.New()
    
    for z = 1, Z do
        grid[x][z] = Random.Noise(x/Random.Number(19,21), z/Random.Number(19,21)) * NOISELEVEL
    end
end
 
for x = 1, X do
    for z = 1, Z do
        local yPos = Math.Round(grid[x][z])
        
        local part
        waitTick(2)
        --part.AddComponent("blockRenderer")
        --part.AddComponent("collider")
        
        if yPos < 3 then
            part = CreatePremade("dirtblox")
            waitTick(1)
        else
            part = CreatePremade("grassblox")
            waitTick(1)
        end
        
        part.position = Vector3.New(x*SCALE, yPos*SCALE, z*SCALE)
        part.size = Vector3.New(SCALE, SCALE, SCALE)
        part.SetParent(GetObjectByName("Ground"))

        -- fill underground / cliffs
        
        local it = 0
        while yPos > 0 do 
            yPos = (yPos - 1)
            it = (it + 1)
            if it < 3 then
                part = CreatePremade("dirtblox")
            else
                part = CreatePremade("stoneblox")
            end
            waitTick(1)
            part.position = Vector3.New(x*SCALE, yPos*SCALE, z*SCALE)
            part.size = Vector3.New(SCALE, SCALE, SCALE)
            part.SetParent(GetObjectByName("Ground"))
        end
        

    end
end

Trees()
end

-- foliage??
function Trees()
local grass = GetObjectById(33).GetChildrenByName("grassblox")
local amount = 0
for i, v in pairs(grass) do
    amount = amount + 1
end

v = 0
i = 0
i2 = 0
while i < ((amount/18)) do
    g = grass[Random.NumberRounded(1, amount)]
    while i2 < 6 do
    part = CreatePremade("woodblox")
    waitTick(2)
    part.position = Vector3.New(g.position.x, g.position.y + SCALE + (i2*SCALE), g.position.z)
    part.size = Vector3.New(SCALE, SCALE, SCALE)
    i2 = i2 + 1
    end
    i = i + 1
end
end
