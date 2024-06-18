function OnPlayerJoin(player)
    if player.username ~= "Jayden82" then
        SendSystemChatToAll(player.username .. " has joined the game")
    else
        SendSystemChatToAll(player.username .. " (admin) has joined the game")
    end
end

function Tick()
    --[[local testVar = Input.LeftMousePressed()
    if (testVar == true) then
        local test = CreateEmptyObject()
        test.name = "Heyo"
        test.position = Vector3.new(7, 2.5, 7)
        test.size = Vector3.new(1, 1, 1)
        local render = test.AddComponent("Renderer")
        local renderer = test.renderer
        renderer.visible = true
        renderer.color = Color.new(255, 255, 255)
        print(test.root)

    end--]]
end

function Begin()
    local test = CreateEmptyObject()
    waitTick(1)
    test.name = "Test"
    test.position = Vector3.New(7, 2.5, 7)
    test.size = Vector3.New(1, 1, 1)

    test.AddComponent("Renderer")
    local ren = test.renderer
    ren.visible = true
    ren.color = Color.New(245, 203, 66, 1)

    test.AddComponent("collider")
    local collide = test.collider
    collide.shape = "Box"
    print(test.name .. " -- testasd")
end