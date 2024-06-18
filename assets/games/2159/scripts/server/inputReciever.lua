function OnNetMessage(netTable)
    if netTable[1] == "showBall" then
        print("showBall")
        print(netTable[2])
        playr = GetPlayerByNetId(netTable[2])

        if GetObjectByName(playr.nickname .. "HoverBall").renderer.visible == false then
            GetObjectByName(playr.nickname .. "HoverBall").renderer.visible = true
            GetObjectByName(playr.nickname .. "HoverBall").collider.enabled = true
        elseif GetObjectByName(playr.nickname .. "HoverBall").renderer.visible == true then
            GetObjectByName(playr.nickname .. "HoverBall").renderer.visible = false
            GetObjectByName(playr.nickname .. "HoverBall").collider.enabled = false
        end

    elseif netTable[1] == "SpreadShoot" then
        print("Shoot")
        print(netTable[2])
        acc = netTable[3]
        bulletRange = netTable[4]
        playr = GetPlayerByNetId(netTable[2])
        char = GetCharacterFromPlayer(playr)


        plyrObj = GetObjectsByName("Bullet")
        for i = 1,5 do
            plyrObj[i].size = Vector3.New(0.1, 0.1, bulletRange)
            plyrObj[i].renderer.visible = true
        end

        
        plyrObj[1].position = char.position + (char.forwardDirection*(bulletRange/2 + 0.5))
        plyrObj[1].rotation = char.rotation 
        plyrObj[2].position = char.position + (char.forwardDirection*(bulletRange/2 + 0.5)) + char.rightDirection*math.sin(math.rad(acc))*bulletRange/2
        plyrObj[2].rotation = char.rotation + Vector3.New(0,acc,0)
        plyrObj[3].position = char.position + (char.forwardDirection*(bulletRange/2 + 0.5)) + char.leftDirection*math.sin(math.rad(acc))*bulletRange/2
        plyrObj[3].rotation = char.rotation + Vector3.New(0,-acc,0)
        plyrObj[4].position = char.position + (char.forwardDirection*(bulletRange/2 + 0.5)) + char.upDirection*math.sin(math.rad(acc))*bulletRange/2
        plyrObj[4].rotation = char.rotation + Vector3.New(-acc,0,0)
        plyrObj[5].position = char.position + (char.forwardDirection*(bulletRange/2 + 0.5)) + char.downDirection*math.sin(math.rad(acc))*bulletRange/2
        plyrObj[5].rotation = char.rotation + Vector3.New(acc,0,0)



        wait(.05)

        for i = 1,5 do
            plyrObj[i].renderer.visible = false
            plyrObj[i].collider.enabled = false
        end

    elseif netTable[1] == "PointShoot" then
        print("Shoot")
        print(netTable[2])
        acc = netTable[3]
        bulletRange = netTable[4]
        playr = GetPlayerByNetId(netTable[2])
        char = GetCharacterFromPlayer(playr)

        plyrObj = GetObjectsByName("Bullet")

        accX = Random.Number(-acc, acc)
        accY = Random.Number(-acc, acc)

        plyrObj[1].size = Vector3.New(0.1, 0.1, bulletRange)
        plyrObj[1].renderer.visible = true
        plyrObj[1].position = char.position + (char.forwardDirection*(bulletRange/2 + 0.5)) + (char.rightDirection * math.sin(math.rad(accY))*bulletRange/2) + (char.downDirection * math.sin(math.rad(accX))*bulletRange/2)
        plyrObj[1].rotation = char.rotation + Vector3.New(accX, accY, 0)
        wait(0.05)
        plyrObj[1].renderer.visible = false
        plyrObj[1].collider.enabled = false
    else
        print("invalid netmessage type")
    end
end