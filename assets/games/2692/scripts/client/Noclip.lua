function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) and isHost then
      wildcard.SetNoClipMovement()
    end
  end