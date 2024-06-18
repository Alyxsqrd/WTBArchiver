local TrainCart = GetObjectById(47)

function OnInteracted(character)
    TrainCart.position = Vector3.New(14.6462, 3.45, 21.8085)
    wait(5)
    TrainCart.position = Vector3.New(24.2462, 3.45, 22.6085)
 end