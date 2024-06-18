function Begin()
    eggObject = GetObjectByName("EggObject")
    eggForce = 20

    Event.Bind(this, "spawnEgg")
end


function spawnEgg(char,dir)
    local tempEgg = DuplicateObject(eggObject)
    tempEgg.position = char.position + dir * 2
    local tempForce = (dir * eggForce)
    tempForce = Vector3.New(tempForce.x,tempForce.y+5,tempForce.z)
    tempEgg.physics.AddForce(tempForce)
end