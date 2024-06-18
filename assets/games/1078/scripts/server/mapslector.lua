function Begin()
    print("started")
    wait(20.0)
    print("changing map")
    players = GetAllPlayers()
    print(players)
    players.position = Vector3.New(-18.7968,2.2173,-7.4944)
end
 