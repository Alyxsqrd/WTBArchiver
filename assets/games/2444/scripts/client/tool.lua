local itema = GetObjectByName("Design")
function OnItemEquipped()
    itema.item.position = itema.item.position + Vector3.New(0, 90, 0)
end