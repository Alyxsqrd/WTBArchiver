function OnInteracted(interactor)
this.RunOnServer("OnTouchBegin", interactor)
end

function OnTouchBegin(wildcard)
  if IsCharacter(wildcard) then
    wildcard.scale = 1
  end
end