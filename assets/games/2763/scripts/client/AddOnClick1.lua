function OnInteracted(character)
   print("clicked add counter")
   local counterText = GetObjectByName("Counter").worldText.text
   local counterNumber = tonumber(counterText) 
   counterNumber = counterNumber + 1 
   GetObjectByName("Counter").worldText.text = tostring(counterNumber)
end
