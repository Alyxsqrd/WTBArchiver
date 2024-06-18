
local camPos = 0
local camDir = 0
local data = 0
local part = 0
local REACH = 15
local SCALE = 1.18
function Tick()
    if(Input.RightMousePressed()) then
        camPos = GetLocalCharacter().cameraPosition
        camDir = GetLocalCharacter().cameraDirection
        data = RayCast(camPos, camDir, REACH)
        if IsObject(data.hitWildcard) then
            Equipped()
            part = CreatePremade(item)
            waitTick(1)
            part.position = Vector3.New(data.hitWildcard.position.x, data.hitWildcard.position.y+SCALE, data.hitWildcard.position.z)
            part.size = Vector3.New(SCALE, SCALE, SCALE)
            PlayOneShotLocal(62, 1.0, 1.0)
        end
    
    elseif(Input.LeftMousePressed()) then
        camPos = GetLocalCharacter().cameraPosition
        camDir = GetLocalCharacter().cameraDirection
        data = RayCast(camPos, camDir, REACH)
        if IsObject(data.hitWildcard) then
            DeleteObject(data.hitWildcard)
            PlayOneShotLocal(64, 1.0, 1.0)
        elseif IsCharacter(data.hitWildcard) then
            this.RunOnServer("Hurt", data.hitWildcard)
        end
    end
end

function Hurt(char)
   char.Damage(5)
end

function Equipped()
    char = GetLocalCharacter()
    if char.HasItemEquipped("grassblox") == true then
        iteme = true
        item = "grassblox"
     elseif char.HasItemEquipped("stoneblox") == true then
        iteme = true
        item = "stoneblox"
     elseif char.HasItemEquipped("woodblox") == true then
        iteme = true
        item = "woodblox"
     elseif char.HasItemEquipped("dirtblox") == true then
        iteme = true
        item = "dirtblox"
     elseif char.HasItemEquipped("iceblox") == true then
        iteme = true
        item = "iceblox"
     elseif char.HasItemEquipped("leafblox") == true then
        iteme = true
        item = "leafblox"
     else
        item = nil
     end
     return item
end