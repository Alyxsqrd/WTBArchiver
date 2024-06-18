
function Begin()
    maxHP = 10
    HP = maxHP
    deathRes = 10
    isAlive = true
    updateHealthBar()
    cnter = 0
    dir = 1
    speed = math.floor(Random.Number(.5,1.5) * 100) / 1000
    target = math.floor(Random.Number(10, 30))
    while true do
        wait(.1)
        if isAlive == true then
            cnter = cnter + 1
            if cnter >= target then
                dir = dir*-1
                cnter = 0
                target = math.floor(Random.Number(10, 30))
            end
            object.position = object.position + Vector3.New(speed * dir,0,0)
        end
    end
end



function OnNetMessage(netTable)
    if netTable[1] == "takeDamage" then
        takeDamage(netTable[3])
    end
end

function takeDamage(dmg)
    if isAlive == true then
        HP = HP - dmg

        updateHealthBar()

        if HP <= 0 then
            isAlive = false
            startSize = Vector3.New(object.size.x, object.size.y, object.size.z)
            for i = 1,deathRes do
                wait(0.5/deathRes)
                object.size = startSize * (1 - (i-1)/deathRes)
            end
            object.renderer.visible = false
            object.collider.enabled = false
            wait(10)
            object.renderer.visible = true
            object.collider.enabled = true
            object.size = Vector3.New(1,1,1)
            HP = maxHP
            isAlive = true
            updateHealthBar()
        end
    end
end

function updateHealthBar()
    string = "["
    for i = 1,HP do
        string = string .. "|"
    end
    for i = 1,math.min(maxHP-HP, 10) do
        string = string .. "-"
    end
    string = string .. "]\v\v\v\v\v\v"

    object.worldText.text = string
end