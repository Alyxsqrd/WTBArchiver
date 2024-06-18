


function StartCollision(other)
    local playerManager = PartByName("Player Manager")
    if (other.type == "Player" and other.id == playerManager.table["taggerNetId"] and IsHost) then
        PartByName("Player Manager").scripts[1].Call("TagRandom")
    end
end