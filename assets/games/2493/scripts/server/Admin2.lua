local FreeAdmin = false
local Prefix = ":"

local PermissionsTable = {1341}

local CMDDictionary
local CMDAliases

function OnPlayerJoin(player)
    if IsModelAdmin(player) == true then
        player.SendSystemChat('You are an administrator in this game! Run ":cmds" to get a list of commands.')
    end
end

function OnPlayerChat(player, message)
    if string.sub(message, 1, 1) ~= Prefix then return end
    if IsModelAdmin(player) == false then return end
    
    local Arguments = SplitString(message)
    local CMDName = string.sub(table.remove(Arguments, 1), 2, -1)
    local CMD = CMDDictionary[CMDName] or CMDAliases[CMDName]

    if CMD then
        CMD.exe(player, Arguments, message)
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

CMDAliases = {
    aaa = CMDDictionary.test
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