local Status = CreatePremade("Status")

while true do
    for i = 10, 0, 1 do
        Status.Text = "Intermission: "..i
        wait(1)
    end

    wait(0)
end