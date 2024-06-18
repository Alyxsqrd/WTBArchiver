

function OnTouchBegin(wildcard)
    if isHost then
        if IsCharacter(wildcard) then
            if wildcard.player.isHost then
                local blowUpBlocks = GetObjectsByName("BlowUp")
                for blockIndex = 1, #blowUpBlocks do
                    blowUpBlocks[blockIndex].physics.enabled = true
                    blowUpBlocks[blockIndex].physics.AddExplosionForce(object.position, 65, 35)
                    branch("RandomizeSizeDelayed", blowUpBlocks[blockIndex])
                end
            end
        end
    end
end

function RandomizeSizeDelayed(block)
    wait(0.1)
    block.size = Vector3.New(Random.Number(1, 3), Random.Number(0.5, 1.5), Random.Number(0.5, 1.5))
end