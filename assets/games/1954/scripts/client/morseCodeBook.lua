local page = 1


function Begin()
    RefreshText()
end

function OnInteracted(character)
    if (page == 1) then
        page = 2
    elseif (page == 2) then
        page = 3
    elseif (page == 3) then
        page = 4
    elseif (page == 4) then
        page = 5
    elseif (page == 5) then
        page = 1
    end

    RefreshText()
end

function RefreshText()
    if (page == 1) then
        object.worldText.text = "Page 1<br>A = .-<br>B = -...<br>C = -.-.<br>D = -..<br>E = .<br><br><br><br><br><br><br><br>"
    elseif (page == 2) then
        object.worldText.text = "Page 2<br>F = ..-.<br>G = --.<br>H = ....<br>I = ..<br>J = .---<br><br><br><br><br><br><br><br>"
    elseif (page == 3) then
        object.worldText.text = "Page 3<br>K = -.-<br>L = .-..<br>M = --<br>N = -.<br>O = ---<br><br><br><br><br><br><br><br>"
    elseif (page == 4) then
        object.worldText.text = "Page 4<br>P = .--.<br>Q = --.-<br>R = .-.<br>S = ...<br>T = -<br><br><br><br><br><br><br><br>"
    elseif (page == 5) then
        object.worldText.text = "Page 5<br>U = ..-<br>V = ...-<br>W = .--<br>X = -..-<br>Y = --.--<br>Z = --..<br><br><br><br><br><br><br><br><br>"
    end
end