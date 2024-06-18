function OnPlayerChat(player, message)
  if isHost then
      GetObjectByName("BottomLine").worldText.text = " "
      object.worldText.text = " "

      local separator = "%s"
      local index = 0
      for str in string.gmatch(message, "([^"..separator.."]+)") do
          str = str.." "
          if index > 8 then
              GetObjectByName("BottomLine").worldText.text = GetObjectByName("BottomLine").worldText.text..str
          else
              object.worldText.text = object.worldText.text..str
          end
          index = index + 1
      end
  end
end
