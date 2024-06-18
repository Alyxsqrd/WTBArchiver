local removalCount = 0  -- Counter for tracking removals

local scoreSynonyms = {
   "Excellent",
   "Superb",
   "Outstanding",
   "Terrific",
   "Wonderful",
   "Splendid",
   "Marvelous",
   "Fabulous",
   "Fantastic",
   "Admirable"
}

local jobSynonyms = {
   "job",
   "work",
   "effort",
   "task",
   "performance",
   "achievement"
}

function Begin()
   print("2nd debug")
end

function OnInteracted(character)
   if GetLocalCharacter().HasItem("Paper") then
      this.RunOnServer("RemoveItem", character)
   else
      this.RunOnServer("Msg", character)
   end
end

function RemoveItem(character)
   GetLocalCharacter().RemoveAllItems()
   removalCount = removalCount + 1
   local randomScoreIndex = math.random(#scoreSynonyms)
   local randomJobIndex = math.random(#jobSynonyms)
   local scoreSynonym = scoreSynonyms[randomScoreIndex]
   local jobSynonym = jobSynonyms[randomJobIndex]
   SendSystemChatToAll(scoreSynonym .. " " .. jobSynonym .. "! You've collected " .. removalCount .. " pieces of litter.")
   object.sound.Play()
end

function Msg(character)
   SendSystemChatToAll("You haven't picked up any litter!")
end

function GameEnd(character)
   SendSystemChatToAll("Game over! You picked up " .. removalCount .. " pieces of litter!")
   GetObjectById(317).worldText.text = removalCount
   removalCount = 0
end