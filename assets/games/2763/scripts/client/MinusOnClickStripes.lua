function OnInteracted(character)
   print("clicked minus counter")
   local counterText = GetObjectByName("Counter2").worldText.text
   local counterNumber = tonumber(counterText) 
   counterNumber = counterNumber - 1 
   GetObjectByName("Counter2").worldText.text = tostring(counterNumber)
end