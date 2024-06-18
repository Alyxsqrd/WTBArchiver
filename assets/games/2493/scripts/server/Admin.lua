local FreeAdmin = false
local Prefix = ":"

local PermissionsTable = {1341}

local CMDDictionary

function OnPlayerJoin(player)
    if IsModelAdmin(player) == true then
        player.SendSystemChat('You are an administrator in this game! Run ":cmds" to get a list of commands.')
    end
end

function OnPlayerChat(player, message)
    if string.sub(message, 1, 1) == Prefix then
        if IsModelAdmin(player) == true then
            local attributes = SplitString(message)

            if attributes[1] == Prefix .. "cmds" then
                player.SendSystemChat("cmds, bring [plr], to [plr], kill [plr], health [plr] [number], heal [plr], ff [plr], unff [plr]")
            end

            if attributes[1] == Prefix .. "gplr" then
                local targetPlayer = GetPlayerViaModel(attributes[1], player)
                local targetPlayer2 = GetPlayerViaModel(attributes[2], player)
                local targetPlayer3 = GetPlayerViaModel(attributes[3], player)
                
                if targetPlayer then
                    if type(targetPlayer) == "table" then
                        print("tg1 is table")
                    else
                        print("tg1 is not table, but exists")
                    end
                else
                    print("tg1 does not exist")
                end

                if targetPlayer2 then
                    if type(targetPlayer2) == "table" then
                        print("tg2 is table")
                    else
                        print("tg2 is not table, but exists")
                    end
                else
                    print("tg2 does not exist")
                end

                if targetPlayer3 then
                    if type(targetPlayer3) == "table" then
                        print("tg3 is table")
                    else
                        print("tg3 is not table, but exists")
                    end
                else
                    print("tg3 does not exist")
                end
            end

            print("got command")

            if attributes[1] == Prefix .. "kick" then
                local targetPlayer = player
                targetPlayer.SendSystemChat("This command is not available at the moment.")
            end

            if attributes[1] == Prefix .. "ban" then
                local targetPlayer = player
                targetPlayer.SendSystemChat("This command is not available at the moment.")
            end
            
            if attributes[1] == Prefix .. "shutdown" then
                local targetPlayer = player
                targetPlayer.SendSystemChat("This command is not available at the moment.")
            end

            if attributes[1] == Prefix .. "kill" then
                local targetPlayer = GetPlayerViaModel(attributes[2], player)
                if targetPlayer then
                    if type(targetPlayer) == "table" then
                        for i, v in pairs(targetPlayer) do
                            local char = v.character
                            if char.forceField == true then char.forceField = false end
                            char.Kill()
                        end
                    else
                        local char = targetPlayer.character
                        if char.forceField == true then char.forceField = false end
                        char.Kill()
                    end
                else
                    CMDError("kill", "That player doesn't exist!", player)
                end
            end

            if attributes[1] == Prefix .. "health" then
                local targetPlayer = GetPlayerViaModel(attributes[2], player)
                if targetPlayer then
                    if type(targetPlayer) == "table" then
                        for i, v in pairs(targetPlayer) do
                            local char = v.character
                            char.health = tonumber(attributes[3])
                        end
                    else
                        local char = targetPlayer.character
                        char.health = tonumber(attributes[3])
                    end
                else
                    CMDError("health", "That player doesn't exist!", player)
                end
            end

            if attributes[1] == Prefix .. "heal" then
                local targetPlayer = GetPlayerViaModel(attributes[2], player)
                if targetPlayer then
                    if type(targetPlayer) == "table" then
                        for i, v in pairs(targetPlayer) do
                            local char = v.character
                            char.health = char.maxHealth
                        end
                    else
                        local char = targetPlayer.character
                        char.health = char.maxHealth
                    end
                else
                    CMDError("heal", "That player doesn't exist!", player)
                end
            end

            if attributes[1] == Prefix .. "forcefield" or attributes[1] == Prefix .. "ff" then
                local targetPlayer = GetPlayerViaModel(attributes[2], player)
                if targetPlayer then
                    if type(targetPlayer) == "table" then
                        for i, v in pairs(targetPlayer) do
                            local char = v.character
                            char.forceField = true
                        end
                    else
                        local char = targetPlayer.character
                        char.forceField = true
                    end
                else
                    CMDError("ff", "That player doesn't exist!", player)
                end
            end

            if attributes[1] == Prefix .. "unforcefield" or attributes[1] == Prefix .. "unff" then
                local targetPlayer = GetPlayerViaModel(attributes[2], player)
                if targetPlayer then
                    if type(targetPlayer) == "table" then
                        for i, v in pairs(targetPlayer) do
                            local char = v.character
                            char.forceField = false
                        end
                    else
                        local char = targetPlayer.character
                        char.forceField = false
                    end
                else
                    CMDError("unff", "That player doesn't exist!", player)
                end
            end

            --[[
            if attributes[1] == Prefix .. "tp" then
                if attributes[2] and attributes[3] then
                    local targetPlayer = GetPlayerViaModel(attributes[2], player)
                    local targetPlayer2 = GetPlayerViaModel(attributes[3], player)
                end
            end
            --]]

            if attributes[1] == Prefix .. "bring" then
                if attributes[2] and attributes[3] then
                    local targetPlayer = GetPlayerViaModel(attributes[2], player)
                    
                    if targetPlayer then
                        if type(targetPlayer) == "table" then
                            for i, v in pairs(targetPlayer) do
                                v.Position = player.Position
                            end
                        else
                            targetPlayer.Position = player.Position
                        end
                    else
                        CMDError("bring", "That player doesn't exist!", player)
                    end
                end
            end

            if attributes[1] == Prefix .. "to" then
                if attributes[2] and attributes[3] then
                    local targetPlayer = GetPlayerViaModel(attributes[2], player)
                    
                    if targetPlayer then
                        if type(targetPlayer) == "table" then
                            --CMDError("to", "Can't teleport to several players at once", player)
                        else
                            player.Position = targetPlayer.Position
                        end
                    else
                        CMDError("bring", "That player doesn't exist!", player)
                    end
                end
            end
        end
    end
end

CMDDictionary = {
    test = {
        cmdtype = "util",
        permlv = 1,
        arguments = {},
        usage = "test",
        enabled = true,
        exe = function(plr, args, msg)
            print("hello world!")
        end
    }
}

function IsModelAdmin(plr)
    if FreeAdmin == false then
        for i, v in pairs(PermissionsTable) do
            if v == plr.id then
                return true
            end
        end
    else
        return true
    end
end

function GetPlayerViaModel(string, functionExecutioner)
    if string == "me" then
        return functionExecutioner
    else
        if string == "all" then
            local playersTable = GetAllPlayers()
            return playersTable
        else
            if string == "others" then
                local playersTable = GetAllPlayers()
                for i, v in pairs(playersTable) do
                    if v.username == functionExecutioner.username then
                        playersTable[v] = nil
                    end
                end
                return playersTable
            else
                local playersTable = GetAllPlayers()
                for i, v in pairs(playersTable) do
                    if string.find(string.lower(v.username), string.lower(string)) then
                        return v
                    end
                end
            end
        end
    end
end

function CMDError(cmd, msg, plr)
    plr.SendSystemChat("[" .. Prefix .. cmd .. ", only you can see this] " .. msg)
end

function SplitString(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end