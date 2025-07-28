SimpleSportMod = SimpleSportMod or {}

function SimpleSportMod.swing(pl, wpn)

    if not wpn or not SimpleSportMod.isThrowable(wpn) then return end
    local user = pl:getUsername()
    local ftype = wpn:getFullType() 
    print(ftype)

end
Events.OnWeaponSwing.Remove(SimpleSportMod.swing)

function SimpleSportMod.OnObjectCollide(pl, wpn)
    if not pl then return end
    if not wpn then return end

    local ftype = wpn:getFullType() 
    if ftype then
        print(ftype)
        print(SimpleSportMod.isThrowable(wpn))
        local fType =  obj:getFullType()
    end
end
Events.OnObjectCollide.Add(SimpleSportMod.OnObjectCollide)

function SimpleSportMod.OnObjectAdded(obj)
    if not obj then return end
    if not instanceof(obj, "IsoWorldInventoryObject") then return end
    local ftype = obj:getFullType() 
    if not ftype then return "OnObjectAdded" end
    print(ftype)
    getPlayer():Say(tostring(ftype)) 
end
Events.OnObjectAdded.Add(SimpleSportMod.OnObjectAdded)
