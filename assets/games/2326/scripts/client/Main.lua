--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

local Block = {}
Block.__index = Block

function Block.New()
    local self = setmetatable({}, Block)

    local object = CreateLocalEmptyObject()
    object.AddComponent("Renderer")
    object.AddComponent("Collider")

    self.object = object
    self.renderer = object.GetComponent("Renderer")
    self.collider = object.GetComponent("Collider")

    return self
end

function Block:Update(objectProperties, rendererProperties, colliderProperties)
    local object = self.object
    for property, value in pairs(objectProperties or {}) do
        object[property] = value
    end

    local renderer = self.renderer
    for property, value in pairs(rendererProperties or {}) do
        renderer[property] = value
    end

    local collider = self.collider
    for property, value in pairs(colliderProperties or {}) do
        collider[property] = value
    end
end

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

local follower = Block.New()
follower:Update(
    {size = Vector3.New(0.25, 0.25, 0.25)},
    {visible = true, shadows = true},
    {enabled = false}
)

function Begin()
    print("Hello, World!")
end

function PhysicsTick()
    local player = GetLocalPlayer()
    if (player == nil) then
        return
    end

    local character = player.character
    if (character == nil) then
        return
    end

    local characterPosition = character.position
    print(characterPosition.x, characterPosition.y, characterPosition.z)
    follower:Update({position = Vector3.New(0, 5, 0)}, nil, nil)
end