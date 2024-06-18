

function Begin()
  if (isHost) then
      object.netTable["red"] = false
  end
end

function OnMouseClick()
  if (isHost) then
      if (object.netTable["red"]) then
          object.netTable["red"] = false
      else
          object.netTable["red"] = true
      end
  end
end

function OnNetTableUpdated()
  if (object.netTable["red"]) then
      -- make it blue
      object.renderer.color = Color.ColorFromHex("#14BDE4")
  else
      -- make it red
      object.renderer.color = Color.ColorFromHex("#FF0000")
 end
end