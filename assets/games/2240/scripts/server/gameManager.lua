function Begin()
    redBall = GetObjectByName("RedBall")
    blueBall = GetObjectByName("BlueBall")

    redPlayers = 0
    bluePlayers = 0

    balls = {}

    Event.Bind(this, "shoot")

    GetObjectById(45).worldText.text = "Not Enough Players"
end

function shoot(team,x,z,rot,forward,netId)
    local newBall = nil
    if team == 0
    then
        newBall = DuplicateObject(redBall)
    else
        newBall = DuplicateObject(blueBall)
    end
    newBall.position = Vector3.New(x,1,z) + (forward)
    newBall.rotation = Vector3.New(0,rot,0)
end
