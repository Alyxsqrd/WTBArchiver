function OnTouchBegin(wildcard)
  if IsCharacter(wildcard) then
    wildcard.gravityPower = 0
  end
end