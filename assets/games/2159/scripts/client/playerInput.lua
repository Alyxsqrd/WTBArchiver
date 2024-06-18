function Begin()
    accuracy = 3
    range = 15
    damage = 2
    canShoot = true
    shootCooldown = 0.3
end


function Tick()
    if (Input.LeftMousePressed()) == true then
        if canShoot == true then
            print(canShoot)
            canShoot = false
            --print(tostring( Input.LeftMousePressed() ))
            --INPUT VARIABLES
            --1: Type of net message
            --2: Player Identifier
            netTable = {"SpreadShoot", GetLocalPlayer().netId, accuracy, range}
            inputReciever = GetObjectByName("inputReciever")
            inputReciever.NetMessagePlayer( GetHostPlayer(), netTable )
            print("1")
            ray = RayCast(GetLocalCharacter().position, GetLocalCharacter().forwardDirection, range)
            hit = ray.hitWildcard
            if IsValid(hit) then
                if hit.name == "Enemy" then
                    if IsValid(hit.GetScriptByName("enemy")) then
                        netTable = {"takeDamage", GetLocalPlayer().netId, damage}
                        hit.NetMessagePlayer(GetHostPlayer(), netTable)
                    end
                end
            end
            shotCooldown()
        end
    elseif (Input.KeyPressed("E")) then
        netTable = {"showBall", GetLocalPlayer().netId}
        inputReciever = GetObjectByName("inputReciever")
        inputReciever.NetMessagePlayer( GetHostPlayer(), netTable )
    end
end

function shotCooldown()
    wait(shootCooldown)
    canShoot = true
end