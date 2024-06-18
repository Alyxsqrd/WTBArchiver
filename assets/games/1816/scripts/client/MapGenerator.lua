-- local MapGenerator = {}

-- function Begin()
--     object.localTable.generate = MapGenerator.generate
-- end



-- MapGenerator.generate = function (map)
--     for _, territory in pairs(map) do
--         MapGenerator.generateTerritoryBlock(territory)
--     end
-- end

-- MapGenerator.generatePart = function (position, size)
--     local part = CreateEmptyObject()
--     waitTick(1)
--     part.AddComponent("renderer")

--     part.position = position
--     part.size = size

--     return part
-- end

-- MapGenerator.generateTerritoryBlock = function (territory)
--     territory.block = MapGenerator.generatePart(territory.position, territory.size)
-- end

-- MapGenerator.generateTerritorySelection = function (territory)

-- end