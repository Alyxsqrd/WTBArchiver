rpgself = GetObjectByName("rocket")

ammo = 5
loaded = true

function OnItemMouseDown()
    if (loaded == false) then
        print("Reload")
    end
    if (loaded == true) then
        print("fired")
        loaded = false
        rpgself.item.light.brightness = 1.0
        wait(10)
        rpgself.item.light.brightness = 0.0
   end
end

function LateTick()
    if (loaded == false and Input.KeyPressed("r") == true and ammo > 0) then
        print("Reloading")
        wait(1)
        ammo = ammo - 1
        loaded = true
        print("Reloaded")
    end
end