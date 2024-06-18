----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

local PlanetUtilities = {}

PlanetUtilities.planets = {}

PlanetUtilities.addPlanet = function(block)
    local planet = {
        block = block,
        rotationVelocity = Vector3.New(
            5 * Random.Number(-1, 1),
            5 * Random.Number(-1, 1),
            5 * Random.Number(-1, 1)
        ),
        lastUpdate = nil
    }

    table.insert(PlanetUtilities.planets, planet)
end

PlanetUtilities.addPlanets = function()
    PlanetUtilities.addPlanet(GetObjectById(1))
    PlanetUtilities.addPlanet(GetObjectById(77))
    PlanetUtilities.addPlanet(GetObjectById(79))
end

PlanetUtilities.getClosestPlanet = function(position)
    local closestPlanet = PlanetUtilities.planets[1]
    local closestDistance = Vector3.Distance(position, closestPlanet.block.position)

    for index = 2, #PlanetUtilities.planets do
        local planet = PlanetUtilities.planets[index]
        local currentDistance = Vector3.Distance(position, planet.block.position)

        if (currentDistance < closestDistance) then
            closestPlanet = planet
            closestDistance = currentDistance
        end
    end

    return closestPlanet
end

PlanetUtilities.getGravityDirection = function(position)
    local closestPlanet = PlanetUtilities.getClosestPlanet(position)
    local gravityDirection = Vector3.Normalize(closestPlanet.block.position - position)

    return gravityDirection
end

PlanetUtilities.updatePlanetRotation = function(planet)
    if (planet.lastUpdate == nil) then
        planet.lastUpdate = Time.time
    end

    local deltaTime = Time.time - planet.lastUpdate
    planet.block.rotation = planet.block.rotation + planet.rotationVelocity * deltaTime
    planet.lastUpdate = Time.time
end

PlanetUtilities.updatePlanets = function()
    for index = 1, #PlanetUtilities.planets do
        local planet = PlanetUtilities.planets[index]
        PlanetUtilities.updatePlanetRotation(planet)
    end
end

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

local GravityUtilities = {}

GravityUtilities.updatePlayerGravity = function(character)
    local newGravityDirection = PlanetUtilities.getGravityDirection(character.position)
    character.gravityDirection = Vector3.Lerp(character.gravityDirection, newGravityDirection, 0.1)
end

GravityUtilities.updatePlayersGravity = function()
    for _, character in pairs(GetAllAliveCharacters()) do
        GravityUtilities.updatePlayerGravity(character)
    end
end

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

function Begin()
    if (isClient) then
        return
    end

    WorldSettings.gravityPower = 0.25
    PlanetUtilities.addPlanets()
end

function PhysicsTick()
    if (isClient) then
        return
    end

    PlanetUtilities.updatePlanets()
    GravityUtilities.updatePlayersGravity()
end