function OnTouchBegin(Arg) -- // Arg is the thing that touched your object
if IsCharacter(Arg) then -- // Check if the thing that we hit is a character
Arg.Kill() -- // It is kill the character
end
end