local admins = {"Lord_7302"} -- VIPs

function OnPlayerJoin(plr)
    if plr.username == "Lord_7302" then
        this.RunOnServer(MSG("The Owner (Lord_7302) has joined the game!"))
    else
        for k, i in pairs(admins) do
            if i == plr.username then 
                this.RunOnServer(MSG("A VIP (" .. plr.username .. ") has joined the game!"))
            end
        end
    end 
end

function OnPlayerChat(plr, msg)
    if msg == ";god" and plr.username == "Lord_7302" then 
        this.RunOnServer(godUser(GetCharacterFromPlayer(plr)))
        this.RunOnServer(MSG("God"))
    elseif msgContains(msg, ";kill") and plr.username == "Lord_7302" then 
        local username = msg.sub(msg,7)
        p = GetPlayerByUsername(username)
        c = GetCharacterFromPlayer(p)
        this.RunOnServer(killUser(c))
    elseif msgContains(msg, ";find") and plr.username == "Lord_7302" then 
        local username = msg.sub(msg,7)
        p = GetPlayerByUsername(username)
        this.RunOnServer(MSG("'" .. p.username .. "' is in the server."))
    elseif msgContains(msg, ";eff") and plr.username == "Lord_7302" then 
        local username = msg.sub(msg,6)
        if username == "" then 
            username = "Lord_7302"
        end
        p = GetPlayerByUsername(username)
        c = GetCharacterFromPlayer(p)
        this.RunOnServer(eff(c))
    elseif msgContains(msg, ";dff") and plr.username == "Lord_7302" then 
        local username = msg.sub(msg,6)
        if username == "" then 
            username = "Lord_7302"
        end
        p = GetPlayerByUsername(username)
        c = GetCharacterFromPlayer(p)
        this.RunOnServer(dff(c))
    elseif msgContains(msg, ";fling") and plr.username == "Lord_7302" then 
        local username = msg.sub(msg,8)
        if username == "" then 
            username = "Lord_7302"
        end
        p = GetPlayerByUsername(username)
        c = GetCharacterFromPlayer(p)
        this.RunOnServer(fling(c))
    elseif msg == ";noclip" and plr.username == "Lord_7302" then 
        this.RunOnServer(noclipUser(GetCharacterFromPlayer(plr)))
    elseif msg == ";clip" and plr.username == "Lord_7302" then 
        this.RunOnServer(xnoclipUser(GetCharacterFromPlayer(plr)))
    elseif msgContains(msg, ";freeze") and plr.username == "Lord_7302" then 
        local username = msg.sub(msg,9)
        if username == "" then 
            username = "Lord_7302"
        end
        p = GetPlayerByUsername(username)
        c = GetCharacterFromPlayer(p)
        this.RunOnServer(freezeUser(c))
    elseif msgContains(msg, ";speed") and plr.username == "Lord_7302" then 
        local spd = msg.sub(msg,8)
        if spd == "" then spd = 1 end
        local speed = tonumber(spd) + 0.1
        this.RunOnServer(Uspeed(GetCharacterFromPlayer(plr),speed))
    elseif msgContains(msg, ";cmd") and plr.username == "Lord_7302" then 
        this.RunOnServer(Rules(plr))
    end
end

function OnCharacterDied(char)
    if char.god == false then 
        MSG(char.nickname .. " died")
    end
end

function MSG(msg)
    SendSystemChatToAll(msg)
end

function DM(p,msg)
    p.SendSystemChat(msg)
end

function godUser(char)
    if char.god == false then
        char.god = true
    else
        char.god = false
    end
end

function killUser(char)
    char.Kill()
end

function eff(char)
    char.forceField = true
end

function dff(char)
    char.forceField = false
end

function fling(char)
    SendSystemChatToAll("Weeeeeeee!!!")
    char.Impulse(Vector3.New(100,100,100))
end

function noclipUser(char)
    char.SetNoClipMovement()
end

function xnoclipUser(char)
    char.SetNormalMovement()
end

function freezeUser(char)
    if char.frozen == false then
        char.frozen = true
    else
        char.frozen = false
    end
end

function Uspeed(char, spd)
    SendSystemChatToAll(spd .. ", " .. (spd - 0.1))
    char.speed = spd - 0.1
end

function Rules(char) -- Command list idk why i called it rules
    DM(char,"All Commands:\n ;eff | ;dff | ;kill | ;speed | ;god| ;noclip | ;clip | ;freeze | ;fling | ;find");
end

function msgContains(msg, str)
    return string.match(' '..msg..' ', '%A'..str..'%A') ~= nil
end