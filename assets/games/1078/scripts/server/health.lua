local mainserver = GetObjectByName("mainserver")

function Begin()
    print("started")
    wait(10.0)
    health = GetLocalCharacter().health
    print(health)
    while true do
        wait(1.0)
        abc()
    end
end

function abc()
    cha = GetLocalCharacter()
    health = cha.health
    print(health)
    mainserver.GetScriptByName("mainserver").Run("killcharacter", cha)
end