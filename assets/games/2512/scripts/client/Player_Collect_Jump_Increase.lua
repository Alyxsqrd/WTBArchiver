isCollected = false

-- Spinning animation
function Tick()
    -- this function is called every frame
    if isCollected == false then
      object.rotation = object.rotation + Vector3.New(0,2,0)
    end
  end

-- Player runs into object
isCollected = false

function OnTouchBegin(wildcard)
  if IsCharacter(wildcard) then
    if isCollected == false then
      isCollected = true
      WorldSettings.jumps = WorldSettings.jumps + 1
      object.sound.PlayLocal()
      object.renderer.visible = false
      wait(1)
      --object.Delete()
    end
  end
end

-- Player collects powerup
--function CollectJumpIncrease()

  
--end