

function Begin()
    local skulls = GetObjectsByName("Skull")
    for i,v in pairs(skulls) do
        if (IsValid(v.physics)) then
            v.physics.AddForce(Random.InSphere(5))
            v.physics.AddTorque(Random.InSphere(20))
        end
    end
end