local sampleMapData = {{neighbors = {5, 4, 2, 3}, position = {x = 5.5, y = 0, z = 3}, size = {x = 4, y = 1, z = 6}}, {neighbors = {3, 1, 6, 7}, position = {x = 10.5, y = 0, z = 5}, size = {x = 6, y = 1, z = 6}}, {neighbors = {2, 8, 4, 1}, position = {x = 9, y = 0, z = -0.5}, size = {x = 3, y = 1, z = 5}}, {neighbors = {1, 3, 9, 10, 5, 8}, position = {x = 4, y = 0, z = -2.5}, size = {x = 7, y = 1, z = 5}}, {neighbors = {1, 12, 11, 10, 4, 6, 13}, position = {x = 0, y = 0, z = 4.5}, size = {x = 7, y = 1, z = 9}}, {neighbors = {2, 13, 5, 7}, position = {x = 5.5, y = 0, z = 9.5}, size = {x = 4, y = 1, z = 7}}, {neighbors = {2, 6}, position = {x = 11.5, y = 0, z = 11.5}, size = {x = 8, y = 1, z = 7}}, {neighbors = {3, 9, 4}, position = {x = 11.5, y = 0, z = -5.5}, size = {x = 8, y = 1, z = 5}}, {neighbors = {4, 8, 10, 16}, position = {x = 3, y = 0, z = -7.5}, size = {x = 9, y = 1, z = 5}}, {neighbors = {4, 5, 9, 14, 16}, position = {x = -2.5, y = 0, z = -2.5}, size = {x = 6, y = 1, z = 5}}, {neighbors = {5, 14, 12}, position = {x = -6, y = 0, z = 3.5}, size = {x = 5, y = 1, z = 7}}, {neighbors = {5, 11, 13}, position = {x = -7.5, y = 0, z = 10.5}, size = {x = 8, y = 1, z = 7}}, {neighbors = {6, 5, 12}, position = {x = 0, y = 0, z = 12.5}, size = {x = 7, y = 1, z = 7}}, {neighbors = {11, 15, 17, 10}, position = {x = -8.5, y = 0, z = -4.5}, size = {x = 6, y = 1, z = 9}}, {neighbors = {14}, position = {x = -13.5, y = 0, z = -4}, size = {x = 4, y = 1, z = 6}}, {neighbors = {9, 10, 17}, position = {x = -3.5, y = 0, z = -10}, size = {x = 4, y = 1, z = 10}}, {neighbors = {14, 16}, position = {x = -9, y = 0, z = -12.5}, size = {x = 7, y = 1, z = 7}}}

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

local MapLoader = {}

MapLoader.load = function (mapData)
    local territories = {}

    for _, territoryData in pairs(mapData) do
        local positionData = territoryData.position
        local position = Vector3.New(positionData.x, 0.625, positionData.z)

        local sizeData = territoryData.size
        local size = Vector3.New(sizeData.x - 0.0125, 0.25, sizeData.z - 0.0125)

        local territory = {
            position = position,
            size = size
        }

        table.insert(territories, territory)
    end

    for index = 1, #territories do
        local territoryData = mapData[index]
        local territory = territories[index]

        local neighbors = {}
        for _, neighborIndex in pairs(territoryData.neighbors) do
            local neighbor = territories[neighborIndex]
            table.insert(neighbors, neighbor)
        end
        territory.neighbors = neighbors
    end

    return territories
end

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

local MapGenerator = {}

MapGenerator.generate = function (map)
    for _, territory in pairs(map) do
        MapGenerator.generateTerritoryBlock(territory)
    end
end

MapGenerator.generatePart = function (position, size)
    local part = CreateEmptyObject()
    waitTick(1)
    part.AddComponent("renderer")

    part.position = position
    part.size = size

    return part
end

MapGenerator.generateTerritoryBlock = function (territory)
    territory.block = MapGenerator.generatePart(territory.position, territory.size)
end

MapGenerator.generateTerritorySelection = function (territory)

end

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

function Begin()
    print("Loading Map")
    local map = MapLoader.load(sampleMapData)
    print("Generating Map")
    MapGenerator.generate(map)

    for _, territory in pairs(map) do
        print(territory.block.position)
    end
end