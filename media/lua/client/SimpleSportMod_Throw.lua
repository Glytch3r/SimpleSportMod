SimpleSportMod = SimpleSportMod or {}

function SimpleSportMod.OnWeaponSwing(atkr, wpn)
    if not instanceof(atkr, "IsoPlayer") then return end
    if not (wpn or SimpleSportMod.isSportItem(wpn)) then return end
    local thrownItem = wpn
    local tickCount = 0

    local inventoryBefore = {}
    for i = 0, atkr:getInventory():getItems():size() - 1 do
        local item = atkr:getInventory():getItems():get(i)
        inventoryBefore[item] = true
    end

    function SimpleSportMod._trackThrownItem()
        tickCount = tickCount + 1
        local thrownItems = {}
        local cell = getCell()
        if not cell then return end

        local plSq = atkr:getSquare()
        if not plSq then return end

        for dx = -4, 4 do
            for dy = -4, 4 do
                local sq = cell:getGridSquare(plSq:getX() + dx, plSq:getY() + dy, plSq:getZ())
                if sq then
                    local objects = sq:getWorldObjects()
                    for j = 0, objects:size() - 1 do
                        local obj = objects:get(j)
                        local item = obj:getItem()
                        if item and item:getFullType() == thrownItem:getFullType() then
                            if not inventoryBefore[item] then
                                print("Landed at: " .. tostring(sq))
                                --sq:transmitRemoveItemFromSquare(item)
                                Events.OnTick.Remove(SimpleSportMod._trackThrownItem)
                                return
                            end
                        end
                    end
                end
            end
        end

        if tickCount > 300 then
            Events.OnTick.Remove(SimpleSportMod._trackThrownItem)
        end
    end

    Events.OnTick.Add(SimpleSportMod._trackThrownItem)
end

--Events.OnWeaponSwing.Add(SimpleSportMod.swing)




function SimpleSportMod.isThrowable(wpn)
    return wpn:getSwingAnim() == 'Throw' or wpn:getScriptItem():getSwingAnim() == 'Throw'
end

function SimpleSportMod.isUnarmed(pl, wpn)
    return tostring(WeaponType.getWeaponType(pl)) == 'barehand' or (wpn and wpn:getCategories():contains("Unarmed"))
end
