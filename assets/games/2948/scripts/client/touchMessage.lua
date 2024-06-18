function OnTouchBegin(wildcard)
  if IsCharacter(wildcard) then
    wildcard.player.SendSystemChat("This is the Chamber.")
  end
end