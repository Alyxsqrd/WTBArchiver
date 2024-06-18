
function OnNetMessage(netTable)
    if netTable[1] == "ballThrow" then
        ballThrow(GetPlayerByNetId(netTable[2]))
    end
end

function OnPlayerJoin(playerJoining)
    cuber = GetObjectByName("throwCube")
    cuber.name = playerJoining.netId .. "throwCube"
end

function ballThrow(passedPlayer)
    print('ball throw')
    if passedPlayer.hasAliveCharacter then
        cube = GetObjectByName(passedPlayer.netId.."throwCube")
        char = GetCharacterFromPlayer(passedPlayer)

        cube.position = char.position + char.forwardDirection*1
        cube.physics.velocity = Vector3.New(0,0,0)
        cube.physics.AddForce(char.forwardDirection*25 + char.upDirection*5)
    end 
end