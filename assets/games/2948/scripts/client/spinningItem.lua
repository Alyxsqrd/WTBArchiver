

local speed = 30;


function Tick()
    if isHost then
        object.rotation = object.rotation + Vector3.New(0, speed * Time.deltaTime, 0)
    end
end

function OnTouchBegin(wildcard)
  if IsCharacter(wildcard) then
    wildcard.player.SendSystemChat("You found the " .. object.name .. "!" )
  end
end
  