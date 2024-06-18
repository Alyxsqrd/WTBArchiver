

function Explode(explodePos)
    if isHost then
        object.physics.AddExplosionForce(explodePos, 5, 25)
        object.physics.AddForce(Vector3.New(0, Random.Number(5, 7.5), 0)) -- extra upwards velocity to mimic inherited velocity from firework
        wait(Random.Number(0.5, 1.5))
        DeleteObject(object)
    end
end