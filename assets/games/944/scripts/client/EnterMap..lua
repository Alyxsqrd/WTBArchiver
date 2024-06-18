


function StartCollision(other)
    local timerTable = PartByName("Timer Table")
    if (other.type == "Player" and IsHost and timerTable.table["intermission"] == false) then
        other.HostSetPosition(PartByName("Not Tagged Spawn").position)
    end
end