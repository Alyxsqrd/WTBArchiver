local seat = GetObjectById("23")
function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
      print(wildcard)
    end
  end

  function OnTouchContinue(wildcard)
    if IsCharacter(wildcard) then
        character.position = seat.position
      end
 end