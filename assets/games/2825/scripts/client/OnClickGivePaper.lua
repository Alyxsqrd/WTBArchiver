local cooldownTime = 3  -- Cooldown time in seconds
local lastInteractionTime = 0  -- Timestamp of the last interaction

function Begin()
   print("Spawned Litter")
   GetObjectById(242).GetScriptByName("GameDuper").Run("RecordRainSpawn", nil)
end

function OnTouchBegin(wildcard)
   if IsCharacter(wildcard) then
      local currentTime = os.time()
      if currentTime - lastInteractionTime >= cooldownTime then
         local character = GetLocalCharacter()
         if not character.HasItem("Paper") then
            GetObjectById(242).GetScriptByName("GameDuper").Run("UnrecordRainSpawn", nil)
            this.RunOnServer("GiveItem", character)
            object.Delete()
         else
            this.RunOnServer("Msg", character)
         end
         lastInteractionTime = currentTime
      end
   end
end

function GiveItem(character)
   GrantItemTo("Paper", character)
end

function Msg(character)
   SendSystemChatToAll("You already have too much litter!")
end
