function OnTouchBegin(wildcard)
  if IsCharacter(wildcard) then
    wildcard.SetNoClipMovement()
  end
end