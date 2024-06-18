function Begin()
  if isHost then
      while true do
        wait(6)
          object.MoveTo(object.position + Vector3.New(0, 10.55, 0), 2.3)
          wait(6)
          object.MoveTo(object.position + Vector3.New(0, 10.55, 0), 2.3)
          wait(6)
          object.MoveTo(object.position + Vector3.New(0, 10.65, 0), 2.3)
          wait(6)
          object.MoveTo(object.position + Vector3.New(0, 10.65, 0), 2.3)
          wait(6)
          object.MoveTo(object.position + Vector3.New(0, -10.65, 0), 2.3)
          wait(6)
          object.MoveTo(object.position + Vector3.New(0, -10.65, 0), 2.3)
          wait(6)
          object.MoveTo(object.position + Vector3.New(0, -10.55, 0), 2.3)
          wait(6)
          object.MoveTo(object.position + Vector3.New(0, -10.55, 0), 2.3)
      end
  end
end