SimpleSportMod = SimpleSportMod or {}
function SimpleSportMod.OnCreate(item)
    if SimpleSportMod.isOnTheFloor(item) then
        local targ = SimpleSportMod.getCatcher(item)
        if targ then
        local sq = targ:getSquare()
            if sq then
                sq:transmitRemoveItemFromSquare(item)
            end
        end
    end
end




function SimpleSportMod.isThrowable(wpn)
    return wpn:getSwingAnim() == 'Throw' or wpn:getScriptItem():getSwingAnim() == 'Throw'
end

function SimpleSportMod.isBall(item)
    if not item or not SimpleSportMod.isItem(item) then return end
    return SimpleSportMod.isThrowable(item) and item:getPhysicsObject()
end


function SimpleSportMod.isUnarmed(pl, wpn)
    return tostring(WeaponType.getWeaponType(pl)) == 'barehand' or (wpn and wpn:getCategories():contains("Unarmed"))
end



function SimpleSportMod.isItem(item)
    return item and (instanceof(item, "InventoryItem") or instanceof(item, "IsoWorldInventoryObject")) 
end

function SimpleSportMod.isOnTheFloor(item)
    return item and item:getWorldItem()
end


function SimpleSportMod.getCatcher(item)
    local sq = nil
    if SimpleSportMod.isOnTheFloor(item) then
        sq = item:getWorldItem():getSquare()
    end
    if sq then
        getPlayer():getCurrentSquare() 
    end

    local targ = nil
    for i=1, sq:getMovingObjects():size() do
        targ = sq:getMovingObjects():get(i-1)
        if targ and instanceof(targ, "IsoPlayer") then
            break
        end
    end
    if targ then
        local user = targ:getUsername() 
        if user then 
            print(user) 
            targ:addLineChatElement('!')
        end       
    end
    return targ
end


