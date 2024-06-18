local endLoop = false
local text = "Hello, . I need your\nhelp to save easter. I will\nreveal more details later.\nFor now, I need you to\ncollect the eggs scattered\naround the map. Thank you."
local downAmount = 0.12

function Begin()
  local x, y, z = -0.0519, 0.95, -4.2511
  while endLoop == false do
    wait(2)
    
    local currentText = ""
    local lines = 0
    
    for i = 1, #text do
      local char = text:sub(i, i)
      currentText = currentText .. char
      object.worldText.text = currentText
      
      if char == "\n" then
        y = y - downAmount
        x, z = -0.0519, -4.2511 -- reset x and z position
        lines = lines + 1
      else
        if char ~= " " then
          wait(0.2)
        end
      end
      
      object.position = Vector3.New(x, y, z)
    end
	
    endLoop = true
  end
end