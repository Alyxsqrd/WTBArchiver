function Begin()
    admins = {"FarawayDrip30"}

    block = GetObjectById(9)
    lava = GetObjectById(67)
    tree = GetObjectById(69)
    car = GetObjectById(71)
    why = GetObjectById(73)
    globe = GetObjectById(75)
end

function OnPlayerChat(player,message)
    if string.sub(message, 1, 1) == ":" then
        --local isAdmin = false
        --for i=1, #admins, 1 do
        --    if player.username == admins[i] then
        --        isAdmin = true
        --        break
        --    end
        --end
        local isAdmin = true
        if isAdmin then
            local command = split(message:lower(), " ")
            local ucommand = split(message," ")
            if command[1] == ":kill" then
                if command[2] then
                    GetPlayerByUsername(ucommand[2]).character.Kill()
                    print("KILLED "..ucommand[2])
                else
                    player.character.Kill()
                    print("KILLED "..player.username)
                end
            elseif command[1] == ":god" then
                player.character.god = true
                print("GODMODE")
            elseif command[1] == ":ungod" then
                player.character.god = false
                print("GODMODE DISABLED")
            elseif command[1] == ":field" then
                player.character.forceField = true
                print("FORCEFIELD")
            elseif command[1] == ":unfield" then
                player.character.forceField = false
                print("FORCEFIELD DISABLED")
            elseif command[1] == ":noclip" then
                player.character.SetNoClipMovement()
                print("NOCLIP")
            elseif command[1] == ":normal" then
                player.character.SetNormalMovement()
                print("NORMALMOVEMENT")
            elseif command[1] == ":speed" then
                if tonumber(command[2]) then
                    player.character.speed = tonumber(command[2])
                    print("SPEED TO "..command[2])
                end
            elseif command[1] == ":gravity" then
                if tonumber(command[2]) then
                    player.character.gravityPower = tonumber(command[2])
                    print("GRAVITY TO "..command[2])
                end
            elseif command[1] == ":gravity2" then
                if tonumber(command[2]) and tonumber(command[3]) and tonumber(command[4]) then
                    player.character.gravityDirection = Vector3.New(tonumber(command[2]),tonumber(command[3]),tonumber(command[4]))
                    print("GRAVITY CHANGED")
                end
            elseif command[1] == ":scale" then
                if tonumber(command[2]) then
                    player.character.scale = tonumber(command[2])
                    print("SCALE TO "..command[2])
                end
            elseif command[1] == ":position" then
                if tonumber(command[2]) and tonumber(command[3]) and tonumber(command[4]) then
                    player.character.position = Vector3.New(tonumber(command[2]),tonumber(command[3]),tonumber(command[4]))
                    print("POSITION CHANGED")
                end
            elseif command[1] == ":invisible" then
                player.character.visible = false
                print("INVISIBLE")
            elseif command[1] == ":visible" then
                player.character.visible = true
                print("VISIBLE")
            
            --World Editing Commands

            elseif command[1] == ":block" then
                spawnObject(block,command,player)
            elseif command[1] == ":lava" then
                spawnObject(lava,command,player)
            elseif command[1] == ":tree" then
                spawnObject(tree,command,player)
            elseif command[1] == ":car" then
                spawnObject(car,command,player)
            elseif command[1] == ":globe" then
                spawnObject(globe,command,player)
            elseif command[1] == ":why" then
                spawnObject(why,command,player)
            elseif command[1] == ":destroy" then
                local hitData = RayCast(player.character.position, player.character.forwardDirection, 10)
                if IsObject(hitData.hitWildcard) then
                    hitData.hitWildcard.Delete()
                    print("DESTROYED "..hitData.hitWildcard.name)
                end
            elseif command[1] == ":rotation" then
                if tonumber(command[2]) and tonumber(command[3]) and tonumber(command[4]) then
                    local hitData = RayCast(player.character.position, player.character.forwardDirection, 10)
                    if IsObject(hitData.hitWildcard) then
                        hitData.hitWildcard.rotation = Vector3.New(tonumber(command[2]),tonumber(command[3]),tonumber(command[4]))
                        print("ROTATED "..hitData.hitWildcard.name)
                    end
                end
            elseif command[1] == ":color" or command[1] == ":colour" then
                if command[2] then
                    local hitData = RayCast(player.character.position, player.character.forwardDirection, 10)
                    if IsObject(hitData.hitWildcard) then
                        hitData.hitWildcard.renderer.color = Color.ColorFromHex(command[2])
                        print("RECOLOURED "..hitData.hitWildcard.name)
                    end
                end
            end
        end
    end
end

function spawnObject(obj,command,player) 
    if tonumber(command[2]) and tonumber(command[3]) and tonumber(command[4]) then
        local tempBlock = obj.Duplicate()
        tempBlock.size = Vector3.New(tonumber(command[2]),tonumber(command[3]),tonumber(command[4]))
        tempBlock.position = player.character.position
        print("PLACED")
    end
end

function split(string, delimiter) -- Got this function from https://helloacm.com/split-a-string-in-lua/
    result = {};

    for match in (string..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end

    return result;
end