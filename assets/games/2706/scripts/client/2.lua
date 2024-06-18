function Begin()
	local character = GetLocalCharacter()
	print("Set the local person properly")
end

function OnCharacterSpawn(character)
	print("printing this because no errors show up in dev log til u print something first idk why")
    character.lockCameraMovement = true
	character.lockCameraZoom = true
	character.isFirstPerson = true
	character.frozen = true
	character.forceField = false
end