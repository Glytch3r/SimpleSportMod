SimpleSportMod = SimpleSportMod or {}



SimpleSportMod.spawn()

function SimpleSportMod.spawn()
    local balls = {
        "Base.SimpleSportMod_Football",
        "Base.SimpleSportMod_Baseball",
        "Base.SimpleSportMod_Basketball",
        "Base.SimpleSportMod_GolfBall",
        "Base.SimpleSportMod_TennisBall",
        "Base.SimpleSportMod_PoolBall",
        "Base.SimpleSportMod_SoccerBall"
    }
    local inv = getPlayer():getInventory() 
    if inv then
        for _, fType in ipairs(fType) do
            inv:AddItem(fType)
        end
    end
    ISInventoryPage.dirtyUI()
end
--[[ 
SimpleSportMod.spawn()

 ]]
--[[ 


function SimpleSportMod.swing(pl, wpn)

    if not wpn or not SimpleSportMod.isThrowable(wpn) then return end
    local user = pl:getUsername()
    local ftype = wpn:getFullType() 
    print(ftype)

end
Events.OnWeaponSwing.Remove(SimpleSportMod.swing)

function SimpleSportMod.OnObjectAdded(obj)
    if not obj then return end
    if not instanceof(obj, "IsoWorldInventoryObject") then return end
    local ftype = obj:getFullType() 
    if not ftype then return "OnObjectAdded" end
    print(ftype)
    getPlayer():Say(tostring(ftype)) 
end
Events.OnObjectAdded.Remove(SimpleSportMod.OnObjectAdded)

function SimpleSportMod.catchHandler(atkr, targ, wpn, dmg)
   if targ == getPlayer() then
      if targ == getPlayer() then
         SimpleSportMod.instaCatch(targ, wpn)
         print("instaCatch")
      end
   end
end

Events.OnWeaponHitCharacter.Remove(SimpleSportMod.catchHandler)
 ]]

--[[ 


local fType = "Base.SimpleSportMod_SoccerBall"

local item = ScriptManager.instance:getItem(fType)
if item then

    item:DoParam("TriggerExplosionTimer = 9")
    item:DoParam("ExplosionTimer = 9")
    item:DoParam("CanBeReused = FALSE")
    item:DoParam("ExplosionPower  =   0")
    item:DoParam("ExplosionRange  =   30")
    item:DoParam("PhysicsObject	=	Molotov")


end
local ball = getPlayer():getCurrentSquare():AddWorldInventoryItem(fType, 0,0,0)
ISInventoryPage.dirtyUI()
SimpleSportMod.setCatchPrepare(getPlayer(), true)  

SimpleSportMod.instaCatch(getPlayer(), ball)

local pl = getPlayer()
local x, y, z = round(pl:getX()),  round(pl:getY()),  pl:getZ() or 0

local sq = getSquare(x, y, z)
for i = 0, sq:getWorldObjects():size() - 1 do
    local obj = sq:getWorldObjects():get(i)
    local item = obj:getItem()
    if item and item:getFullType() == "Base.SimpleSportMod_SoccerBall" then
        obj:setWorldPos(newX, newY, newZ)
        obj:transmitCompleteItemToClients()
        break
    end
end


 ]]

--[[ 
local sq = getSquare(x, y, z)
for i = 0, sq:getWorldObjects():size() - 1 do
    local obj = sq:getWorldObjects():get(i)
    local item = obj:getItem()
    if item and item:getFullType() == "Base.SimpleSportMod_SoccerBall" then
        obj:setWorldPos(newX, newY, newZ)
        obj:transmitCompleteItemToClients()
        break
    end
end
 ]]
