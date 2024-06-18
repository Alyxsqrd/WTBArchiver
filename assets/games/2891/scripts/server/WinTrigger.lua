function OnTouchBegin(touched)
    SendSystemChatToAll(touched.username.." has finished!")
    touched.position = Vector3.new(0.5, 5.9, 59.5001)
end