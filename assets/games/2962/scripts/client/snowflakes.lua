function Begin()
  while true do
     object.MoveTo(Vector3.New(object.position.x, -400, object.position.z), 56.0)
     wait(56.1)
     object.position = Vector3.New(object.position.x, 556, object.position.z)
     wait(0.1)
  end
end

