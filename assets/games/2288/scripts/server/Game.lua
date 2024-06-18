local Lava = GetObjectByName("Lava")

local Settings = {
    MinPlayers = 1
}

local Maps = {
    GetObjectByName("Map1")
}

local InitializedMaps = {}

function Begin()
    print("Began")

    for i, v in pairs(Maps) do
        v.position = Vector3.New(v.position.x, (v.position.y - 75), v.position.z)
    end

    while true do
        print("Repeat")
        if #GetAllPlayers() < Settings.MinPlayers then
            SendSystemChatToAll("Waiting for minimum players.. (" .. Settings.MinPlayers .. " players required)")
            repeat wait(0.25) until GetAllPlayers() >= Settings.MinPlayers
        end

        for RoundIntermission = 5, 1, -1 do
            SendSystemChatToAll("The round will start in " .. RoundIntermission .. " second(s)!")
        end

        local Map = Maps[math.random(1, #Maps)]:Clone()
        local MapSpawn = Map.GetChildByName("Spawn")
        InitializeMap(Map)

        Map.position = Vector3.New(Map.position.x, (Map.position.y + 75), Map.position.z)


        for i, v in pairs(GetAllCharacters()) do
            v.position = MapSpawn.position
            v.rotation = MapSpawn.rotation
        end

        Map.position = Vector3.New(Map.position.x, (Map.position.y - 75), Map.position.z)

        wait(5)
    end
end

function InitializeMap(map)
    if CheckIfInitialized(map) == true then
        return
    end
    table.insert(InitializedMaps, #InitializedMaps + 1, map.Name)

    local Planks = map.GetChildrenByName("Plank")
    for i, v in pairs(Planks) do
        v.Transparency = 0.5
    end
end

function CheckIfInitialized(map)
    for i, v in pairs(InitializedMaps) do
        if v.Name == map.Name then
            return true
        end
    end
    return false
end