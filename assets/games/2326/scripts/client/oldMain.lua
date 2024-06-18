--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// UTILITY

function exact_equal_vector3(a, b)
    return a.x == b.x and a.y == b.y and a.z == b.z
end

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// BLOCK

local SAMPLE_BLOCK = GetObjectById(5)

function create_block()
    return DuplicateObject(SAMPLE_BLOCK)
end

function destroy_block(block)
    block.Delete()
end

function edit_block(block, object_properties, renderer_properties, collider_properties)
    for property, value in pairs(object_properties or {}) do
        block[property] = value
    end

    local renderer = block.renderer
    for property, value in pairs(renderer_properties or {}) do
        renderer[property] = value
    end

    local collider = block.collider
    for property, value in pairs(collider_properties or {}) do
        collider[property] = value
    end
end

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// BLOCK MANIPULATION

function beam_block(block, start_position, end_position, thickness)
    local distance = Vector3.Distance(start_position, end_position)
    local direction = Vector3.Direction(start_position, end_position)

    local position = Vector3.Lerp(start_position, end_position, 0.5)
    local size = Vector3.New(thickness, thickness, distance)
    local rotation = Vector3.LookRotation(direction, Vector3.New(0, 1, 0))

    edit_block(block, { position = position, rotation = rotation, size = size })
end

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// BLOCK POOL

function create_blockpool(hard_target_amount, soft_target_amount, get_edit_block, return_edit_block)
    local blockpool = {
        hard_target_amount = hard_target_amount or 25,
        soft_target_amount = soft_target_amount or 100,
        get_edit_block = get_edit_block or function() end,
        return_edit_block = return_edit_block or function() end,
        block_count = 0,
        busy_blocks = {},
        free_blocks = {}
    }

    for i = 1, hard_target_amount do
        create_block_blockpool(blockpool)
    end

    return blockpool
end

function destroy_blockpool(blockpool)
    for block, _ in pairs(blockpool.busy_blocks) do
        destroy_block(block)
    end

    for block, _ in pairs(blockpool.free_blocks) do
        destroy_block(block)
    end
end

function create_block_blockpool(blockpool)
    local block = create_block()
    blockpool.free_blocks[block] = true
    blockpool.block_count = blockpool.block_count + 1
    return block
end

function destroy_block_blockpool(blockpool, block)
    blockpool.free_blocks[block] = nil
    blockpool.busy_blocks[block] = nil
    destroy_block(block)
    blockpool.block_count = blockpool.block_count - 1
end

function get_block_blockpool(blockpool)
    local block = next(blockpool.free_blocks)
    if block then
        blockpool.free_blocks[block] = nil
        blockpool.busy_blocks[block] = true
    else
        block = create_block_blockpool(blockpool)
    end

    blockpool.get_edit_block(block)
    return block
end

function return_block_blockpool(blockpool, block)
    blockpool.busy_blocks[block] = nil
    blockpool.free_blocks[block] = true

    if blockpool.block_count > blockpool.hard_target_amount then
        destroy_block_blockpool(blockpool, block)
    else
        blockpool.return_edit_block(block)
    end
end

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// CHUNK

local CHUNK_SIZE = 4

local CHUNK_LIFE_STATUS = {
    CHUNK_GENERATING = 0,
    CHUNK_GENERATED = 1,
    CHUNK_VISUALIZING = 2,
    CHUNK_VISUALIZED = 3,
    CHUNK_DEVISUALIZING = 4
}

local DEBUG_VISUALIZATION_BEAM_PAIRS = {
    { Vector3.New(0, 0, 0), Vector3.New(0, 0, 1) },
    { Vector3.New(1, 0, 0), Vector3.New(1, 0, 1) },
    { Vector3.New(0, 0, 0), Vector3.New(1, 0, 0) },
    { Vector3.New(0, 0, 1), Vector3.New(1, 0, 1) },
    { Vector3.New(0, 1, 0), Vector3.New(0, 1, 1) },
    { Vector3.New(1, 1, 0), Vector3.New(1, 1, 1) },
    { Vector3.New(0, 1, 0), Vector3.New(1, 1, 0) },
    { Vector3.New(0, 1, 1), Vector3.New(1, 1, 1) },
    { Vector3.New(0, 0, 0), Vector3.New(0, 1, 0) },
    { Vector3.New(1, 0, 0), Vector3.New(1, 1, 0) },
    { Vector3.New(0, 0, 1), Vector3.New(0, 1, 1) },
    { Vector3.New(1, 0, 1), Vector3.New(1, 1, 1) },
}

local chunk_debug_blockpool = create_blockpool(25, 100,
    function(block) edit_block(block, {}, { visible = true, color = Color.New(0.75, 0, 0) }, { enabled = false }) end,
    function(block) edit_block(block, {}, { visible = false }, { enabled = false }) end
)

local chunk_blockpool = create_blockpool(250, 1000,
    function(block) edit_block(block, { size = Vector3.New(1, 1, 1) }, { visible = true }, { enabled = false }) end
    ,
    function(block) edit_block(block, {}, { visible = false }, { enabled = false }) end
)

function create_chunk(chunk_position)
    return {
        position = chunk_position,
        debug_visualization_blocks = {},
        blocks_data = {},
        visualization_blocks = {},
        generation_index = Vector3.New(1, 1, 1),
        visualization_index = Vector3.New(1, 1, 1),
        life_status = CHUNK_LIFE_STATUS.CHUNK_GENERATING
    }
end

function destroy_chunk(chunk)
    debug_devisualize_chunk(chunk)
end

function can_generate_chunk(chunk)
    return chunk.life_status ~= CHUNK_LIFE_STATUS.CHUNK_VISUALIZED
end

function generate_chunk(chunk, steps)
    if chunk.life_status == CHUNK_LIFE_STATUS.CHUNK_VISUALIZED then return end

    if chunk.life_status == CHUNK_LIFE_STATUS.CHUNK_GENERATING then
        generate_blocks_data_chunk(chunk, steps)
        if exact_equal_vector3(chunk.generation_index, Vector3.New(CHUNK_SIZE, CHUNK_SIZE, CHUNK_SIZE)) then
            chunk.life_status = CHUNK_LIFE_STATUS.CHUNK_GENERATED
        end
    elseif chunk.life_status == CHUNK_LIFE_STATUS.CHUNK_GENERATED or
        chunk.life_status == CHUNK_LIFE_STATUS.CHUNK_VISUALIZING then
        visualize_chunk(chunk, steps)
        if exact_equal_vector3(chunk.visualization_index, Vector3.New(CHUNK_SIZE, CHUNK_SIZE, CHUNK_SIZE)) then
            chunk.life_status = CHUNK_LIFE_STATUS.CHUNK_VISUALIZED
        end
    end
end

function can_degenerate_chunk(chunk)
    return chunk.life_status ~= CHUNK_LIFE_STATUS.CHUNK_GENERATING and
        chunk.life_status ~= CHUNK_LIFE_STATUS.CHUNK_GENERATED
end

function degenerate_chunk(chunk, steps)
    if chunk.life_status == CHUNK_LIFE_STATUS.CHUNK_GENERATING or
        chunk.life_status == CHUNK_LIFE_STATUS.CHUNK_GENERATED then return end

    if chunk.life_status == CHUNK_LIFE_STATUS.CHUNK_VISUALIZED or
        chunk.life_status == CHUNK_LIFE_STATUS.CHUNK_DEVISUALIZING then
        devisualize_chunk(chunk, steps)
        if exact_equal_vector3(chunk.visualization_index, Vector3.New(1, 1, 1)) then
            chunk.life_status = CHUNK_LIFE_STATUS.CHUNK_GENERATED
        end
    end
end

function debug_visualize_chunk(chunk)
    local chunk_position = chunk.position

    for _, beam_pair in pairs(DEBUG_VISUALIZATION_BEAM_PAIRS) do
        local start_position = chunk_position + beam_pair[1] * CHUNK_SIZE
        local end_position = chunk_position + beam_pair[2] * CHUNK_SIZE

        local block = get_block_blockpool(chunk_debug_blockpool)
        beam_block(block, start_position, end_position, 0.1)
        table.insert(chunk.debug_visualization_blocks, block)
    end
end

function debug_devisualize_chunk(chunk)
    for _, block in pairs(chunk.debug_visualization_blocks) do
        return_block_blockpool(chunk_debug_blockpool, block)
    end
    chunk.debug_visualization_blocks = {}
end

function generate_blocks_data_chunk(chunk, steps)
    local blocks_data = chunk.blocks_data
    local x, y, z = chunk.generation_index.x, chunk.generation_index.y, chunk.generation_index.z
    while (x <= CHUNK_SIZE) do
        while (y <= CHUNK_SIZE) do
            while (z <= CHUNK_SIZE) do
                if steps <= 0 then
                    chunk.generation_index = Vector3.New(x, y, z)
                    return
                end

                blocks_data[x * CHUNK_SIZE * CHUNK_SIZE + y * CHUNK_SIZE + z] = Random.Number(0, 1) < 0.25 and 1 or 0

                steps = steps - 1
                if z >= CHUNK_SIZE then z = 1 break else z = z + 1 end
            end
            if y >= CHUNK_SIZE then y = 1 break else y = y + 1 end
        end
        if x >= CHUNK_SIZE then x = 1 break else x = x + 1 end
    end

    chunk.generation_index = Vector3.New(x, y, z)
end

function visualize_chunk(chunk, steps)
    local blocks_data = chunk.blocks_data
    local x, y, z = chunk.visualization_index.x, chunk.visualization_index.y, chunk.visualization_index.z
    while (x <= CHUNK_SIZE) do
        while (y <= CHUNK_SIZE) do
            while (z <= CHUNK_SIZE) do
                if steps <= 0 then
                    chunk.visualization_index = Vector3.New(x, y, z)
                    return
                end

                local block_data = blocks_data[x * CHUNK_SIZE * CHUNK_SIZE + y * CHUNK_SIZE + z]
                if block_data == 1 then
                    local block = get_block_blockpool(chunk_blockpool)
                    local block_position = chunk.position + Vector3.New(x - 1, y - 1, z - 1)
                    edit_block(block, { position = block_position })
                    table.insert(chunk.visualization_blocks, block)
                else
                    table.insert(chunk.visualization_blocks, nil)
                end

                steps = steps - 1
                if z >= CHUNK_SIZE then z = 1 break else z = z + 1 end
            end
            if y >= CHUNK_SIZE then y = 1 break else y = y + 1 end
        end
        if x >= CHUNK_SIZE then x = 1 break else x = x + 1 end
    end

    chunk.visualization_index = Vector3.New(x, y, z)
end

function devisualize_chunk(chunk, steps)
    local visualization_blocks = chunk.visualization_blocks
    local x, y, z = chunk.visualization_index.x, chunk.visualization_index.y, chunk.visualization_index.z
    while (x >= 1) do
        while (y >= 1) do
            while (z >= 1) do
                print(x, y, z)
                if steps <= 0 then
                    chunk.visualization_index = Vector3.New(x, y, z)
                    return
                end

                local block = table.remove(visualization_blocks)
                if block ~= nil then
                    return_block_blockpool(chunk_blockpool, block)
                end

                steps = steps - 1
                if z <= 1 then z = CHUNK_SIZE break else z = z - 1 end
            end
            if y <= 1 then y = CHUNK_SIZE break else y = y - 1 end
        end
        if x <= 1 then x = CHUNK_SIZE break else x = x - 1 end
    end

    print(x, y, z)
    chunk.visualization_index = Vector3.New(x, y, z)
end

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// CHUNK MANIPULATION

function chunk2world_position(chunk_position)
    return chunk_position * CHUNK_SIZE
end

function world2chunk_position(world_position)
    return Vector3.New(math.floor(world_position.x / CHUNK_SIZE),
        math.floor(world_position.y / CHUNK_SIZE),
        math.floor(world_position.z / CHUNK_SIZE)
    )
end

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


local chunk

function Begin()
    print("Hello, World!")
end

function OnCharacterSpawn(character)
    chunk = create_chunk(Vector3.New(0, 0, 0))
    debug_visualize_chunk(chunk)
    generate_blocks_data_chunk(chunk, 64)
    visualize_chunk(chunk, 64)
end

function OnCharacterDied(character)
    destroy_chunk(chunk)
    chunk = nil
end

function PhysicsTick()
    if not chunk then return end

    local character_position = localPlayer.character.position
    local new_chunk_x = math.floor(character_position.x / CHUNK_SIZE) * CHUNK_SIZE
    local new_chunk_y = math.floor(character_position.y / CHUNK_SIZE) * CHUNK_SIZE
    local new_chunk_z = math.floor(character_position.z / CHUNK_SIZE) * CHUNK_SIZE

    local new_chunk_position = Vector3.New(new_chunk_x, new_chunk_y, new_chunk_z)
    local old_chunk_position = chunk.position
    local is_new_chunk = new_chunk_position.x ~= old_chunk_position.x or
        new_chunk_position.y ~= old_chunk_position.y or
        new_chunk_position.z ~= old_chunk_position.z

    if is_new_chunk then
        print(chunk.visualization_index)
        devisualize_chunk(chunk, 64)
        print(chunk.visualization_index)
        debug_devisualize_chunk(chunk)
        chunk.position = new_chunk_position
        debug_visualize_chunk(chunk)
        generate_blocks_data_chunk(chunk, 64)
        visualize_chunk(chunk, 64)
    end
end
