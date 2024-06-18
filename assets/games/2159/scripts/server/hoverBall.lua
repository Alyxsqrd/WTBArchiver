
function Begin()
    object.localTable["target"] = "none"
    resolution = 12
    while true do
        wait(1/resolution)
        if object.localTable["target"] != "none" then 
            if IsCharacter(GetCharacterFromPlayer(object.localTable["target"])) then
                xx = math.floor(GetCharacterFromPlayer(object.localTable["target"]).position.x + 0.5)
                yy = math.floor(GetCharacterFromPlayer(object.localTable["target"]).position.y + 4 + 0.5)
                zz = math.floor(GetCharacterFromPlayer(object.localTable["target"]).position.z + 0.5)
                object.position = Vector3.New(xx,yy,zz)
            end
        end
    end
end