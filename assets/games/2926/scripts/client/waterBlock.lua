local selector = CreatePremade("Selector")
local currentblock = "WB"

function Tick()
    if Character.HasItemEquipped("Block") then
        sx = Math.RoundUp(Input.mouseWorldPosition.x)
        sy = Math.RoundUp(Input.mouseWorldPosition.y)
        sz = Math.RoundUp(Input.mouseWorldPosition.z)
        selector.position = Vector3.New(sx, sy, sz)
      if(Input.LeftMousePressed()) then
            print(Input.mouseWorldPosition)
          local part = CreatePremade(currentblock)
            clickedx = Math.RoundUp(Input.mouseWorldPosition.x)
            clickedy = Math.RoundUp(Input.mouseWorldPosition.y)
            clickedz = Math.RoundUp(Input.mouseWorldPosition.z)
            waitTick(1)
            part.position = Vector3.New(clickedx, clickedy, clickedz)
        end
    end
end