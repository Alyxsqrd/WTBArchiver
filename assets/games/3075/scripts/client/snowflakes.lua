function Begin()
  while true do
     object.MoveTo(Vector3.New(object.position.x, -30, object.position.z), 59.0)
     wait(59.1)
     object.position = Vector3.New(object.position.x, 56, object.position.z)
     wait(0.1)
  end
end

