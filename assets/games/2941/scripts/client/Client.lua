--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// MAIN //--

local LOCAL_BLOCKS = GetObjectById(12)

local function ClientMain()
    print("Hello from client!")

    for _, block in pairs(LOCAL_BLOCKS.GetDirectChildren()) do
        block.position = Vector3.New(0, math.random(2, 8), 0)
        print(block.id)
    end
end

local function ServerMain()
    print("Hello from server!")
end

--// RUN //--

if (isClient or isHost) then
    ClientMain()
end

if (isServer or isHost) then
    ServerMain()
end