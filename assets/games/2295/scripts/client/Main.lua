--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// Replicated Namespace //--

Replicated = {

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// Global Variables //--

    TemplateBases = {
        {
            Baseplate = GetObjectById(29),
            Bounds = GetObjectById(49),
        },
        {
            Baseplate = GetObjectById(21),
            Bounds = GetObjectById(39),
        },
        {
            Baseplate = GetObjectById(30),
            Bounds = GetObjectById(47),
        },
        {
            Baseplate = GetObjectById(23),
            Bounds = GetObjectById(41),
        },
        {
            Baseplate = GetObjectById(31),
            Bounds = GetObjectById(45),
        },
        {
            Baseplate = GetObjectById(25),
            Bounds = GetObjectById(43),
        }
    },

    TemplateBlock = GetObjectById(37),

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// Network Namespace //--

    Network = {

        SerializePlayer = function(player)
            return player.username
        end,

        DeserializePlayer = function(playerString)
            for _, player in pairs(GetAllPlayers()) do
                if player.username == playerString then
                    return player
                end
            end
        end,

        SerializeVector3 = function(vector3)
            return vector3.x .. "," .. vector3.y .. "," .. vector3.z
        end,

        DeserializeVector3 = function(vector3String)
            local x, y, z = string.match(vector3String, "(-?%d+%.?%d*),(-?%d+%.?%d*),(-?%d+%.?%d*)")
            return Vector3.new(tonumber(x), tonumber(y), tonumber(z))
        end

    },

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// Space Namespace //--

    Space = {

        Create = function(position, size)
            local self = {
                Position = position,
                Size = size,
                Data = {}
            }

            return self
        end,

        PositionInBounds = function(self, position)
            local minimum = self.Position - self.Size / 2
            local maximum = self.Position + self.Size / 2

            return position.x >= minimum.x and position.x <= maximum.x and
                position.y >= minimum.y and position.y <= maximum.y and
                position.z >= minimum.z and position.z <= maximum.z
        end,

        PositionToIndex = function(self, position)
            local minimum = self.Position - self.Size / 2
            local displacement = position - minimum

            local x = displacement.x == 0 and 1 or math.ceil(displacement.x)
            local y = displacement.y == 0 and 1 or math.ceil(displacement.y)
            local z = displacement.z == 0 and 1 or math.ceil(displacement.z)

            return "" .. x .. "," .. y .. "," .. z
        end,

        IndexToPosition = function(self, index)
            local x, y, z = string.match(index, "(-?%d+),(-?%d+),(-?%d+)")

            local minimum = self.Position - self.Size / 2
            local displacement = Vector3.new(x - 0.5, y - 0.5, z - 0.5)

            return minimum + displacement
        end,

        GenerateBlock = function(self, index)
            if self.Data[index] == nil then
                self.Data[index] = {
                    IsOccupied = false,
                    IsGenerated = false,
                    Block = nil
                }
            end

            local datum = self.Data[index]
            local block = DuplicateObject(Replicated.TemplateBlock)
            local position = Replicated.Space.IndexToPosition(self, index)

            block.position = position
            datum.IsGenerated = true
            datum.Block = block
        end,

        DegenerateBlock = function(self, index)
            if (self.Data[index] == nil) then
                return
            end

            local datum = self.Data[index]
            local block = datum.Block

            DeleteObject(block)
            datum.IsGenerated = false
            datum.Block = nil

            if (datum.IsOccupied == false) then
                self.Data[index] = nil
            end
        end,

        SyncGeneration = function(self)
            for index, datum in pairs(self.Data) do
                if (datum.IsOccupied and not datum.IsGenerated) then
                    Replicated.Space.GenerateBlock(self, index)
                elseif (not datum.IsOccupied and datum.IsGenerated) then
                    Replicated.Space.DegenerateBlock(self, index)
                end
            end
        end,

        UserAction = function(self, cameraPosition, mousePosition, place)
            local hitData = Replicated.Space.UserActionValid(self, cameraPosition, mousePosition)

            if (not hitData) then
                return
            end

            if (place) then
                Replicated.Space.PlaceBlock(self, hitData)
            else
                Replicated.Space.RemoveBlock(self, hitData)
            end

            Replicated.Space.SyncGeneration(self)
        end,

        UserActionValid = function(self, cameraPosition, mousePosition)
            local distance = Vector3.Distance(cameraPosition, mousePosition) + 0.1

            if (distance > 32) then
                return
            end

            local direction = Vector3.Direction(cameraPosition, mousePosition)
            local hitData = RayCast(cameraPosition, direction, distance)

            if (IsObject(hitData.hitWildcard)) then
                return hitData
            end
        end,

        PlaceBlock = function(self, hitData)
            local hitPosition = hitData.hitPosition + hitData.hitDirection * 0.1

            if (not Replicated.Space.PositionInBounds(self, hitPosition)) then
                return
            end

            local index = Replicated.Space.PositionToIndex(self, hitPosition)
            local datum = self.Data[index]
            if (datum) then
                datum.IsOccupied = true
            else
                self.Data[index] = {
                    IsOccupied = true,
                    IsGenerated = false,
                    Block = nil
                }
            end
        end,

        RemoveBlock = function(self, hitData)
            local hitPosition = hitData.hitPosition - hitData.hitDirection * 0.1

            if (not Replicated.Space.PositionInBounds(self, hitPosition)) then
                return
            end

            local index = Replicated.Space.PositionToIndex(self, hitPosition)
            local datum = self.Data[index]
            if (datum) then
                datum.IsOccupied = false
            end
        end

    },

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// Base Namespace //--

    Base = {

        Create = function(baseplate, bounds)
            local self = {
                Baseplate = baseplate,
                Bounds = bounds,
                Space = Replicated.Space.Create(bounds.position, bounds.size),
                Owner = nil
            }

            self.Bounds.worldText.text = "Unoccupied"

            return self
        end,

        Occupy = function(self, player)
            self.Owner = player
            self.Bounds.worldText.text = player.username .. "'s Base"
        end,

        Vacate = function(self)
            self.Owner = nil
            self.Bounds.worldText.text = "Unoccupied"
        end,

        UserAction = function(self, player, cameraPosition, mousePosition, place)
            if (self.Owner == nil) then
                return
            end

            if (self.Owner == player) then
                Replicated.Space.UserAction(self.Space, cameraPosition, mousePosition, place)
            end
        end
    }

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

}

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// Client Namespace //--

Client = {

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// Global Variables //--

    Base = nil,

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// Global Functions //--

    Initialize = function()

    end,

    InputHandler = function()
        if (Input.LeftMousePressed() or Input.MiddleMousePressed()) then
            Client.SendBlockActionNetMessage()
        end
    end,

    SendBlockActionNetMessage = function()
        if (not localPlayer.hasAliveCharacter) then
            return
        end

        local character = localPlayer.character
        local cameraPosition = character.cameraPosition
        local mousePosition = Input.mouseWorldPosition
        local place = Input.LeftMousePressed()

        local message = {
            Type = "UserAction",
            Player = Replicated.Network.SerializePlayer(localPlayer),
            Payload = {
                CameraPosition = Replicated.Network.SerializeVector3(cameraPosition),
                MousePosition = Replicated.Network.SerializeVector3(mousePosition),
                Place = place
            }
        }

        NetMessageGlobalPlayer(hostPlayer, message)
    end

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

}

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// Server Namespace //--

Server = {

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// Global Variables //--

    Bases = {},

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// Global Functions //--

    Initialize = function()
        Server.InitializeBases()
    end,

    InitializeBases = function()
        for _, templateBase in pairs(Replicated.TemplateBases) do
            local baseplate = templateBase.Baseplate
            local bounds = templateBase.Bounds

            local base = Replicated.Base.Create(baseplate, bounds)
            table.insert(Server.Bases, base)
        end
    end,

    NetMessageHandler = function(message)
        if (message.Type == "UserAction") then
            local player = Replicated.Network.DeserializePlayer(message.Player)
            local cameraPosition = Replicated.Network.DeserializeVector3(message.Payload.CameraPosition)
            local mousePosition = Replicated.Network.DeserializeVector3(message.Payload.MousePosition)
            local place = message.Payload.Place

            for _, base in pairs(Server.Bases) do
                Replicated.Base.UserAction(base, player, cameraPosition, mousePosition, place)
            end
        end
    end

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

}

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--// Execution //--

function Begin()
    --// fixes a bug where output is not shown in the console unless something is first printed to the console
    print("Begin")

    if (isHost) then
        Server.Initialize()
    end

    Client.Initialize()
end

function OnPlayerJoin(player)
    if (isHost) then
        local base = Server.Bases[1]
        Replicated.Base.Occupy(base, player)
    end
end

function Tick()
    if (isHost) then

    end

    Client.InputHandler()
end

function OnNetMessage(message)
    Server.NetMessageHandler(message)
end

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------