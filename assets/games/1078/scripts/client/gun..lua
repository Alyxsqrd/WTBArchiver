function Update()
    if InputPressed("mouse 0") then
      shot()
    end
end
function shot()
    local range = 20
       print("shoot")
      -- find the position the player is shooting at
      local shootpos = LocalPlayer().viewPwosition + LocalPlayer().viewForward * range

    -- draw a line between the player and where they're looking
      local hitdata = RayCast(LocalPlayer().viewPosition, shootpos)

      -- make an emptry variable for the player
      local hitplayer = nil
      if (hitdata.hitObject ~= nil and hitdata.hitObject.type == "Part") then
      print("hit");
      hitplayer = hitdata.hitObject
      end

    if (hitplayer ~=nil) then
           print("hit")
        NetworkSendToPlayer("kill", "kill", nil, hitplayer)
      end
end

function NetworkStringReceive(msgName)
    if (msgName == "kill") then
        LocalPlayer().position = newVector3(0, 13, 0)
    end
 end 