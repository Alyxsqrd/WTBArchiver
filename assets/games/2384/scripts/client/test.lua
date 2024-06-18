

function Begin()
    wait(2)
    print("waited 2 secs on Begin")
end

function OnInteracted(character)
    printScreen(_G["testG"], 5, Color.green)
end
