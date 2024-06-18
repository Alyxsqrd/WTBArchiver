function Begin()
    redScore = 0
    blueScore = 0
end

function ResetBall()
    object.position = Vector3.New(0,2.1,0)
    object.rotation = Vector3.New(0,0,0)
    object.physics.velocity = Vector3.New(0,0,0)

    object.collider.shape = "Box"
end

function OnTouchBegin(touched)
    if(touched.name == "Blue Net")
    then
        ResetBall()
        redScore = redScore + 1
        GetObjectById(2681).worldText.text = tostring(redScore)
        GetObjectById(2690).worldText.text = tostring(redScore)
    else
        if(touched.name == "Red Net")
        then
            ResetBall()
            blueScore = blueScore + 1
            GetObjectById(2689).worldText.text = tostring(blueScore)
            GetObjectById(2683).worldText.text = tostring(blueScore)
        else
            if(touched.name == "Grass")
            then
                object.collider.shape = "Sphere"
                object.physics.velocity = Vector3.New(0,0,0)
            end
        end
    end
 end

 function PhysicsTick()
    if(object.position.x > 24 or object.position.x < -24 or object.position.y < -5 or object.position.y > 10 or object.position.z > 16 or object.position.z < -16)
    then
        ResetBall()
    end
 end