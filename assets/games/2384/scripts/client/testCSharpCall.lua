

function OnInteracted(wildcard)
    _G["testG"] = "wowee it works!"
end

function OnMouseClick()
    Vector3.ThrowEx()
end

function OnTouchBegin(wildcard)
    local x = nil
    for i = 1,x do
        print("test waaa")
    end
end