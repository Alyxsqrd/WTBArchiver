----------------------------------------------------------
local ws, ss, sss
--------------------------------------------------------
--
function SetColor(o, clr) if o and o.renderer then o.renderer.color = clr end end --Can be modular
--
function Destroy(o) if isServer then if type(o.Remove) == "function" then o.Remove() else DeleteObject(o) end end end --Can be modular
--------------------------------------------------------
function c3(r,g,b) return Color.New(r/255,g/255,b/255) end --Cannot be modular, returns a value, suffer
--
function GNm(n) return GetObjectByName(n) end --Cannot be modular, returns a value, suffer
--
function GNms(nms) local r = {} for i = 1,#nms do r[i] = _.GNm(nms[i]) end return table.unpack(r) end --Cannot be modular, returns a value, suffer
--
function Clone(o) if isServer then return DuplicateObject(o) end end --Cannot be modular, returns a value, suffer
--
function In(class, pr) class = class:lower() --Cannot be modular, returns a value, suffer
    local p 
    --
    if class == "part" or class == "ppart" or class == "folder" or class == "model" then --object
        if isServer then p = CreateEmptyObject() else p = CreateLocalEmptyObject() end 
        waitTick(1) 
        if class == "part" or class == "ppart" then 
            p.SetParent(ss)
            local a = _.In("Renderer", p) local c = _.In("Collider", p) 
            if class == "ppart" then local phys = _.In("Physics", p) end
            p.SetParent(pr)
        end
    elseif isServer and class == "renderer" or class == "collider" or class == "respawn" or class == "script" or class == "physics" then --component
        p = pr.AddComponent(class) waitTick(1)
    end
    --
    return p
end
--
--------------------------------------------------------
function Begin() 
    local rs = GetObjectByName("DD") 
    ws, ss, sss = _.GNms({"Workspace","ServerStorage","ServerScriptService"})
    --
    table.insert(rs.netTable,"SetColor")
    table.insert(rs.netTable,"c3")
    table.insert(rs.netTable,"GNm")
    table.insert(rs.netTable,"GNms")
    table.insert(rs.netTable,"Destroy")
    table.insert(rs.netTable,"Clone")
    table.insert(rs.netTable,"In")
    --
    print("PACKING FUNCTIONS")
end
--------------------------------------------------------