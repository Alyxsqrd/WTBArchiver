local endLoop = false
local text = "The easter bunny exploded or something.."

function Begin()
  while endLoop == false do
    wait(12)
    
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