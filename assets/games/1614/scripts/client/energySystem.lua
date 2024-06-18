local energy = math.random(0, 100)
local energyBar

function Start()
    if not IsHost then
        energyBar = MakeUIPanel(newVector2(ScreenSize.x / 2 - 200, ScreenSize.y - 55))
        energyBar.color = newColor(0.6, 0.6, 0.6, 0.5)
    end
end

function Update()
    if not IsHost and energyBar then
        energyBar.size = newVector2((energy / 100) * 50, 0)
    end
end