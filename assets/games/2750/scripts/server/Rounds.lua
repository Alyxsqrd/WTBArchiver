local count
local MapTP
local Lava = object.GetChildByName("Lava")
local Info = object.GetChildByName("Info")
local Countdown = object.GetChildByName("Countdown")
local TPs = object.GetChildByName("TPs")

function Begin()
    -- Initial Intermission
    Info.worldText.text = "Initial Intermission"
    MapTP = Math.Round(Random.Number(1,1))
    print(MapTP)
    count = 20
    counter()
    Lava.MoveTo(TPs.GetChildByName(MapTP).position + Vector3.New(0, -9, 0), 0)
    tpAll()

    loop()
end

-- Main Loop
function loop()
    --Round
    Info.worldText.text = "In Round"
    MapTP = 0
    count = 100
    counter()
    tpAll()

    --Intermission
    Info.worldText.text = "Intermission"
    MapTP = Math.Round(Random.Number(1,2))
    print(MapTP)
    count = 15
    counter()
    Lava.MoveTo(TPs.GetChildByName(MapTP).position + Vector3.New(0, -9, 0), 0)
    tpAll()

    loop()
end

--Teleport players to their destination!
function tpAll()
    Countdown.worldText.text = "Teleporting..."
    wait(1.2)
    local GAAC = GetAllAliveCharacters()
    print(GAAC)
    for i, v in pairs(GAAC) do
        v.position = TPs.GetChildByName(MapTP).position
    end
end

--Countdown
function counter()
    Countdown.worldText.text = count
    count = count - 1
    wait(1)
    if count != -1 then
        counter()
    end
end