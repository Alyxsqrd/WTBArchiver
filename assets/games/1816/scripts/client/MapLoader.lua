-- local MapLoader = {}

-- function Begin()
--     object.localTable.load = MapLoader.load
-- end



-- MapLoader.load = function (mapData)
--     local territories = {}

--     for _, territoryData in pairs(mapData) do
--         local positionData = territoryData.position
--         local position = Vector3.New(positionData.x, positionData.y, positionData.z)

--         local sizeData = territoryData.size
--         local size = Vector3.New(sizeData.x, sizeData.y, sizeData.z)

--         local territory = {
--             position = position,
--             size = size
--         }

--         table.insert(territories, territory)
--     end

--     for index = 1, #territories do
--         local territoryData = mapData[index]
--         local territory = territories[index]

--         local neighbors = {}
--         for _, neighborIndex in pairs(territoryData.neighbors) do
--             local neighbor = territories[neighborIndex]
--             table.insert(neighbors, neighbor)
--         end
--         territory.neighbors = neighbors
--     end

--     return territories
-- end