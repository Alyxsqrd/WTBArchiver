local function Round(n)
	return n % 1 < 0.5 and math.floor(n) or math.ceil(n)
end

--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--

local PartCache = {}

--// STATIC PROPERTIES //--

PartCache.ClassName = "PartCache"

--// CONSTRUCTOR //--

function PartCache.new(defaultPart)
	local self = setmetatable({}, PartCache)

	--// INSTANCE PROPERTIES //--

	self.DefaultPart = defaultPart or CreatePart(0, newVector3(math.huge, 0, 0))
	self.GeneratedParts = {}

	self.InactiveParts = {}
	self.ActiveParts = {}

	--////--

	return self
end

--// STATIC METHODS //--

--// INSTANCE METHODS //--

function PartCache:GeneratePart()
	local part = self.DefaultPart.Duplicate()
	self.GeneratedParts[part] = true
	self.InactiveParts[part] = true
	return part
end

function PartCache:DegeneratePart(part)
	self.GeneratedParts[part] = nil
	self.InactiveParts[part] = nil
	self.ActiveParts[part] = nil
	part.Remove()
end

function PartCache:GetPart(position, size)
	local part = next(self.InactiveParts)

	if not part then
		part = self:GeneratePart()
	end

	self.InactiveParts[part] = nil
	self.ActiveParts[part] = true

	part.position = position
	part.size = size
	part.transparency = 0
	part.cancollide = true
	return part
end

function PartCache:ReleasePart(part)
	part.position = newVector3(0, -50, 0)
	self.ActiveParts[part] = nil
	self.InactiveParts[part] = true
end

--// INSTRUCTIONS //--

PartCache.__index = PartCache

--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--

local Surface = {}

--// STATIC PROPERTIES //--

Surface.ClassName = "Surface"

Surface.GenerateFunction = function(surface) end

Surface.DegenerateFunction = function(surface) end

--// CONSTRUCTOR //--

function Surface.new(position, size, depth)
	local self = setmetatable({}, Surface)

	--// INSTANCE PROPERTIES //--
	self.Surfaces = {}

	self.Position = position
	self.Size = size
	self.Depth = depth or 0
	--////--

	if self.Depth == 0 then
		Surface.GenerateFunction(self)
	end

	return self
end

--// STATIC METHODS //--

--// INSTANCE METHODS //--

function Surface:Subdivide()
	if #self.Surfaces == 0 then
		local position = self.Position
		local subdividedSize = self.Size / 2
		local newDepth = self.Depth + 1

		table.insert(
			self.Surfaces,
			Surface.new(
				newVector3(position.x - subdividedSize.x / 2, position.y, position.z - subdividedSize.z / 2),
				subdividedSize,
				newDepth
			)
		)
		table.insert(
			self.Surfaces,
			Surface.new(
				newVector3(position.x + subdividedSize.x / 2, position.y, position.z - subdividedSize.z / 2),
				subdividedSize,
				newDepth
			)
		)
		table.insert(
			self.Surfaces,
			Surface.new(
				newVector3(position.x + subdividedSize.x / 2, position.y, position.z + subdividedSize.z / 2),
				subdividedSize,
				newDepth
			)
		)
		table.insert(
			self.Surfaces,
			Surface.new(
				newVector3(position.x - subdividedSize.x / 2, position.y, position.z + subdividedSize.z / 2),
				subdividedSize,
				newDepth
			)
		)

		Surface.DegenerateFunction(self)
		for _, surface in pairs(self.Surfaces) do
			Surface.GenerateFunction(surface)
		end
	end
end

function Surface:Merge()
	if #self.Surfaces == 4 then
		for _, surface in pairs(self.Surfaces) do
			surface:Merge()
			Surface.DegenerateFunction(surface)
		end
		self.Surfaces = {}
		Surface.GenerateFunction(self)
	end
end

function Surface:Update(playerPosition)
	local distance = (playerPosition - self.Position).magnitude
	if distance < 2 * self.Size.x then
		if self.Depth <= 2 then
			self:Subdivide()
			for _, surface in pairs(self.Surfaces) do
				surface:Update(playerPosition)
			end
		end
	else
		self:Merge()
	end
end

--// INSTRUCTIONS //--

Surface.__index = Surface

--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--

local BlockCoordinator = {}

--// STATIC PROPERTIES //--

BlockCoordinator.ClassName = "BlockCoordinator"

--// CONSTRUCTOR //--

function BlockCoordinator.new(scale)
	local self = setmetatable({}, BlockCoordinator)

	--// INSTANCE PROPERTIES //--

	self.Scale = scale or 32

	--////--

	return self
end

--// STATIC METHODS //--

--// INSTANCE METHODS //--

function BlockCoordinator:GetBlockPositionFromWorldPosition(worldPosition)
	return newVector3(Round(worldPosition.x / self.Scale), 0, Round(worldPosition.z / self.Scale))
end

function BlockCoordinator:GetWorldPositionFromBlockPosition(blockPosition)
	return newVector3(blockPosition.x * self.Scale, 0, blockPosition.z * self.Scale)
end

function BlockCoordinator:GetBlockPositionFromBlockId(blockId)
	local x, y, z = blockId:match("%[([%+%-]?%d+%),([%+%-]?%d+%),([%+%-]?%d+%)%]")
	return newVector3(x, y, z)
end

function BlockCoordinator:GetBlockIdFromBlockPosition(blockPosition)
	return string.format("[%s,%s,%s]", blockPosition.x, blockPosition.y, blockPosition.z)
end

--// INSTRUCTIONS //--

BlockCoordinator.__index = BlockCoordinator

--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--

local BlockSolidifier = {}

--// STATIC PROPERTIES //--

BlockSolidifier.ClassName = "BlockSolidifier"
BlockSolidifier.Super = BlockCoordinator

--// CONSTRUCTOR //--

function BlockSolidifier.new()
	local self = setmetatable(BlockSolidifier.Super.new(), BlockSolidifier)

	--// INSTANCE PROPERTIES //--
	self.PartCache = PartCache.new(PartByName("Grass"))
	--////--

	Surface.GenerateFunction = function(surface)
		local surfacePosition = surface.Position
		local surfaceSize = surface.Size

		local noise = Random.Noise(surfacePosition.x * 0.023241, surfacePosition.z * 0.016543) * 8
		noise = noise + Random.Noise(surfacePosition.x * 0.046531, surfacePosition.z * 0.042572) * 4

		local part = self.PartCache:GetPart(
			newVector3(surfacePosition.x, noise / 2, surfacePosition.z),
			newVector3(surfaceSize.x, noise, surfaceSize.z)
		)

		surface.Part = part
	end

	Surface.DegenerateFunction = function(surface)
		if surface.Part then
			self.PartCache:ReleasePart(surface.Part)
			surface.Part = nil
		end
	end

	return self
end

--// STATIC METHODS //--

--// INSTANCE METHODS //--

function BlockSolidifier:GenerateBlockAtWorldPosition(worldPosition)
	local block = Surface.new(newVector3(worldPosition.x, 0, worldPosition.z), newVector3(self.Scale, 0, self.Scale))
	return block
end

--// INSTRUCTIONS //--

BlockSolidifier = setmetatable(BlockSolidifier, BlockSolidifier.Super)
BlockSolidifier.__index = BlockSolidifier

--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--

local BlockManager = {}

--// STATIC PROPERTIES //--

BlockManager.ClassName = "BlockManager"
BlockManager.Super = BlockSolidifier

--// CONSTRUCTOR //--

function BlockManager.new()
	local self = setmetatable(BlockManager.Super.new(), BlockManager)

	--// INSTANCE PROPERTIES //--
	self.RenderDistance = 3

	self.GeneratedBlocks = {}
	--////--

	return self
end

--// STATIC METHODS //--

--// INSTANCE METHODS //--

function BlockManager:GetBlocksToGenerate()
	local playerPosition = GetLocalPlayer().position
	local playerBlockPosition = self:GetBlockPositionFromWorldPosition(playerPosition)

	local blocksToGenerate = {}
	for x = playerBlockPosition.x - self.RenderDistance, playerBlockPosition.x + self.RenderDistance do
		for z = playerBlockPosition.z - self.RenderDistance, playerBlockPosition.z + self.RenderDistance do
			local blockPosition = newVector3(x, 0, z)
			local blockId = self:GetBlockIdFromBlockPosition(blockPosition)
			blocksToGenerate[blockId] = blockPosition
		end
	end
	return blocksToGenerate
end

function BlockManager:UpdateBlocks()
	local playerPosition = GetLocalPlayer().position
	playerPosition = newVector3(playerPosition.x, 0, playerPosition.z)
	for _, surface in pairs(self.GeneratedBlocks) do
		surface:Update(playerPosition)
	end

	local blocksToGenerate = self:GetBlocksToGenerate()

	for blockId, block in pairs(self.GeneratedBlocks) do
		if blocksToGenerate[blockId] then
			blocksToGenerate[blockId] = nil
		else
			block:Merge()
			Surface.DegenerateFunction(block)
			self.GeneratedBlocks[blockId] = nil
		end
	end

	for blockId, blockPosition in pairs(blocksToGenerate) do
		self.GeneratedBlocks[blockId] = self:GenerateBlockAtWorldPosition(
			self:GetWorldPositionFromBlockPosition(blockPosition)
		)
	end
end

--// INSTRUCTIONS //--

BlockManager = setmetatable(BlockManager, BlockManager.Super)
BlockManager.__index = BlockManager

--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////--

local blockManager = BlockManager.new()

blockManager:UpdateBlocks()

function Update()
	blockManager:UpdateBlocks()
end
