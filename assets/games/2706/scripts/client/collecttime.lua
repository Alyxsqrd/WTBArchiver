local endLoop = false
local text = "It's time to get out there and collect!"

function Begin()
  while endLoop == false do
    wait(37)
    
    local currentText = ""
    
    for i = 1, #text do
      local char = text:sub(i, i)
      currentText = currentText .. char
      object.worldText.text = currentText
      
      if char ~= " " then
        wait(0.2)
      end
    end
	
    endLoop = true
  end
end