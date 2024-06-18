----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

local Particle = {}

Particle.template = nil

Particle.initialize = function()
    Particle.template = CreateEmptyObject()
    waitTick(1)
    Particle.template.AddComponent("renderer")
    Particle.template.renderer.visible = false
end

Particle.new = function()
    local self = {
        object = nil,
        renderer = nil
    }

    self.object = DuplicateObject(Particle.template)
    self.renderer = self.object.renderer

    return self
end

Particle.destroy = function(self)
    DeleteObject(self.object)
end

Particle.update = function(self, objectProperties, rendererProperties)
    for property, value in pairs(objectProperties or {}) do
        self.object[property] = value
    end

    for property, value in pairs(rendererProperties or {}) do
        self.renderer[property] = value
    end
end

Particle.updateAsBeam = function(self, startPosition, endPosition, thickness)
    local distance = Vector3.Distance(startPosition, endPosition)
    local direction = Vector3.Normalize(endPosition - startPosition)

    local position = startPosition + direction * distance * 0.5
    local size = Vector3.new(thickness, thickness, distance)
    local rotation = Vector3.LookRotation(direction, Vector3.New(0, 1, 0))

    Particle.update(self, {
        position = position,
        size = size,
        rotation = rotation
    })
end

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

local Cache = {}

Cache.new = function(
    hardResourceCountMinimum, softResourceCountMinimum,
    createResourceFunction, destroyResourceFunction,
)
    local self = {
        hardResourceCountMinimum = hardResourceCountMinimum,
        softResourceCountMinimum = softResourceCountMinimum,
        resourceCount = 0,
        freeResources = {},
        busyResources = {},

        createResourceFunction = createResourceFunction,
        destroyResourceFunction = destroyResourceFunction,
    }

    for counter = 1, hardResourceCountMinimum do
        Cache.createResource(self)
    end

    return self
end

Cache.destroy = function(self)
    for resource, _ in pairs(self.freeResources) do
        self.destroyResourceFunction(resource)
    end

    for resource, _ in pairs(self.busyResources) do
        self.destroyResourceFunction(resource)
    end
end

Cache.createResource = function(self)
    local resource = self.createResourceFunction()
    self.resourceCount = self.resourceCount + 1
    self.freeResources[resource] = true

    return resource
end

Cache.destroyResource = function(self, resource)
    if (self.freeResources[resource] == nil and self.busyResources[resource] == nil) then
        return
    end

    self.freeResources[resource] = nil
    self.busyResources[resource] = nil
    self.destroyResourceFunction(resource)
    self.resourceCount = self.resourceCount - 1
end

Cache.grabResource = function(self)
    local resource = next(self.freeResources)
    if (resource == nil) then
        resource = Cache.createResource(self)
    end

    self.freeResources[resource] = nil
    self.busyResources[resource] = true

    return resource
end

Cache.releaseResource = function(self, resource)
    if (self.freeResources[resource] == nil and self.busyResources[resource] == nil) then
        return
    end

    self.freeResources[resource] = true
    self.busyResources[resource] = nil

    if (self.resourceCount > self.softResourceCountMinimum) then
        Cache.destroyResource(self, resource)
    end
end

Cache.forEach = function(self, action)
    for resource, _ in pairs(self.busyResources) do
        action(resource)
    end
end

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------



----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

local particleCache = nil

function Begin()
    print("Hello, World!")
    Particle.initialize()
    particleCache = Cache.new(10, 50, Particle.new, Particle.destroy)
end

function PhysicsTick()
    print(particleCache.resourceCount)

    if (localPlayer.hasAliveCharacter) then

        Cache.forEach(particleCache, function(particle)
            local distance = Vector3.Distance(localPlayer.character.position, particle.object.position)
            if (distance < 1) then
                Cache.releaseResource(particleCache, particle)
                Particle.update(particle, nil, { visible = false })
            end

            local newPosition = Vector3.Lerp(particle.object.position, localPlayer.character.position, 0.1)
            Particle.update(particle, { position = newPosition })
        end)

        if (Random.Number(1, 100) <= 100) then
            local particle = Cache.grabResource(particleCache)
            Particle.update(particle,
                {
                    position = localPlayer.character.position + Random.InSphere(25),
                    size = Vector3.New(0.25, 0.25, 0.25)
                },
                {
                    color = Color.New(1, 0, 0),
                    visible = true
                }
            )

            print(particle.object.position)
        end

    end
end