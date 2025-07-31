SimpleSportMod = SimpleSportMod or {}

function SimpleSportMod.doThrow(pl, wpn, targSq)
    if not wpn then return end
    if not SimpleSportMod.isSportItem(wpn) then return end

    local thrownLoc = pl:getCurrentSquare()
    SimpleSportMod.step = 0
    SimpleSportMod.targX = round(targSq:getX())
    SimpleSportMod.targY = round(targSq:getY())
    local flr = targSq:getFloor()
    local fType =  wpn:getFullType()

    if flr then
        flr:setHighlightColor(1, 0, 0, 1)
        flr:setHighlighted(true, false)
    end

    function SimpleSportMod.onTick()
        local ball = wpn:getWorldItem()

        if not ball then
            -- Rotate while item is still not on the floor
            SimpleSportMod.step = (SimpleSportMod.step + 0.2) % 360
            wpn:setWorldZRotation(SimpleSportMod.step)
            return
        end

        local ballX = ball:getWorldPosX()
        local ballY = ball:getWorldPosY()
        local dist = thrownLoc:DistTo(ballX, ballY)

        ISRemoveItemTool.removeItem(wpn, pl:getPlayerNum())

        local spawnedBall = targSq:AddWorldInventoryItem(tostring(fType), 0, 0, 0)
--[[         spawnedBall:setWorldPosX(SimpleSportMod.targX)
        spawnedBall:setWorldPosY(SimpleSportMod.targY) ]]

        pl:setHaloNote("Ball Landed! "..tostring(dist), 150, 250, 150, 200)
        Events.OnTick.Remove(SimpleSportMod.onTick)

        if flr then
            flr:setHighlightColor(0, 1, 0, 1)
            flr:setHighlighted(true, true)
        end
        if dist < 3 then

        end
    end

    Events.OnTick.Add(SimpleSportMod.onTick)
end

function SimpleSportMod.swing(pl, wpn)
    if wpn and SimpleSportMod.isThrowable(wpn) then
        local targSq = SimpleSportMod.getPointer()
        if targSq then
            SimpleSportMod.doThrow(pl, wpn, targSq)
        end
    end
end

Events.OnWeaponSwing.Remove(SimpleSportMod.swing)
Events.OnWeaponSwing.Add(SimpleSportMod.swing)
