function OnTouchBegin(touched)
    print("lmao")
    if(touched.name == "Blue Net")
    then
        object.position = Vector3.New(0,3,0)
    else
        if(touched.name == "Red Net")
        then
            object.position = Vector3.New(0,3,0)
        end
    end
 end