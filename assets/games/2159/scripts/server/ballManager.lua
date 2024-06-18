function OnPlayerJoin(plyr)
    balls = GetObjectByName("HoverBall")
    balls.localTable["target"] = plyr
    balls.name = plyr.nickname .. "HoverBall"
end