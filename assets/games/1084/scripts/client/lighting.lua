local a1 = GetObjectById(1436)
local a2 = GetObjectById(1438)
local a3 = GetObjectById(1440)

local b1 = GetObjectById(1444)
local b2 = GetObjectById(1445)
local b3 = GetObjectById(1446)

local c1 = GetObjectById(1448)
local c2 = GetObjectById(1449)
local c3 = GetObjectById(1450)

local b = GetObjectById(244)

function Begin()
    while true do
        check()
end

function check()
    if b.netTable["temp"] >= 970 then
        a1.renderer.visible = true
        a2.renderer.visible = true
        a3.renderer.visible = true
        wait(0.25)
        a1.renderer.visible = false
        a2.renderer.visible = false
        a3.renderer.visible = false
        wait(0.25)
        b1.renderer.visible = true
        b2.renderer.visible = true
        b3.renderer.visible = true
        wait(0.25)
        b1.renderer.visible = false
        b2.renderer.visible = false
        b3.renderer.visible = false
        wait(0.25)
        c1.renderer.visible = true
        c2.renderer.visible = true
        c3.renderer.visible = true
        wait(0.25)
        c1.renderer.visible = false
        c2.renderer.visible = false
        c3.renderer.visible = false
        wait(0.25)
    end
end