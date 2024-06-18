local endLoop = false
local text = "Hello, tyster. I need \nyour help to save\neaster. I will reveal\nmore details later.\nFor now, I need you\nto collect the eggs\nscattered around\nthe map."

function Begin()
  while endLoop == false do
    wait(6)
    
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