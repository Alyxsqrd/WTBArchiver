function OnInteracted(interactor)
this.RunOnServer("OnTouchBegin", interactor)
end

function OnTouchBegin(wildcard)
  if IsCharacter(wildcard) then
    wildcard.scale = 0.1
  end
end