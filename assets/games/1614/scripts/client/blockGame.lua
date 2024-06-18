-- Coded just for fun.

local DEBUG = true

local NULL_VECTOR3 = newVector3(0, 0, 0)

local BLOCK_SIZE = 1.25
local BLOCK_NAME = "_Block"
local BLOCK_TYPES = {
    { 
        name = "Grass",
        color = newColor(0.8, 0.2, 0, 1)
    }
}

local BLOCK_SIZE_VECTOR3 = newVector3(BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE)

local blocks = {}

function grid(position, size)
    return (math.round(position / size) * size)
end

function debug(message)
    if DEBUG then
        print("DEBUG: " .. message)
    end
end

function PlaceBlock(position, type) 
    if not BLOCK_TYPES[type] then
        print("OUCH: Attempting to place undefined type. (" .. tostring(type) .. ")")
        return
    end
    
    local alignedPosition = newVector3(grid(position.x, BLOCK_SIZE), grid(position.y, BLOCK_SIZE), grid(position.z, BLOCK_SIZE))

    for _, block in pairs(blocks) do
        if block.position == alignedPosition then
            print("HUH: Placing a block in the same place.")
            return
        end
    end

    debug("Placing a block... (" .. tostring(position.x) .. "," .. tostring(position.y) .. "," .. tostring(position.z) .. ", " .. tostring(type) .. ")")

    local block = CreatePart(0, alignedPosition, NULL_VECTOR3)
    block.size = BLOCK_SIZE_VECTOR3
    block.color = BLOCK_TYPES[type].color
    block.name = BLOCK_NAME
    
    table.insert(blocks, block)
end

function Update()
    if InputPressed("mouse 0") then
        local position = MousePosWorld()

        debug("Clicked. (" .. position.x .. ", " .. position.y .. ", " .. position.z .. ")")

        if not IsHost then
            NetworkSendToHost("place_block", {x = position.x, y = position.y, z = position.z, type = 1})
        else
            PlaceBlock(position, 1)
        end
    end
end

function NetworkStringReceive(player, name, data)
    debug("Got network message from " .. tostring(player.name) .. ": " .. tostring(name))

    if name == "place_block" then
        if not data.type or not data.x or not data.y or not data.z then
            print("OUCH: Got the non-compliant data from placing block.")
            return
        end

        PlaceBlock(newVector3(data.x, data.y, data.z), data.type)
    end
end