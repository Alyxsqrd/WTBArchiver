function OnMouseClick()
    local health = 25
    local hit = Random.Number(7, 14)
    
    if health > 0 then 
       health = health-hit
    end
    waitTick(1)
    print(health)
 end