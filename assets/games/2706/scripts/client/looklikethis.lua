local endLoop = false
local text = "They look like this:"

function Begin()
  while endLoop == false do
    wait(30)
    
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