local SCALE = 1.18

local iteme
local item

function OnMouseClick()
   nid = GetLocalCharacter().netId
   this.RunOnServer("stuff", nid)
end

function stuff(nid)
   local char = GetCharacterByNetId(nid)
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
   else
   object.Delete()
   PlayOneShotLocal(64, 1.0, 1.0)
   end

   if iteme == true then
      part = CreatePremade(item)
      waitTick(1)
      part.position = Vector3.New(object.position.x, object.position.y + SCALE, object.position.z)
      part.size = Vector3.New(SCALE, SCALE, SCALE)
      PlayOneShotLocal(62, 1.0, 1.0)
   end
end