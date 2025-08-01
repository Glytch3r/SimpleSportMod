SimpleSportMod = SimpleSportMod or {}

-----------------------
ISWaitForCatchAction = ISBaseTimedAction:derive("ISWaitForCatchAction")

function ISWaitForCatchAction:isValid()
   return tostring(WeaponType.getWeaponType(self.character)) == "barehand"
end

function ISWaitForCatchAction:start()
   self:setAnimVariable("isCatchWaiting", true)
   self:setActionAnim("WaitToCatch")
   SimpleSportMod.setReachMarker()
end

function ISWaitForCatchAction:update()
   local csq = self.character:getCurrentSquare() 
   local item, ball, targSq  = SimpleSportMod.findSportItem(csq)
   if item then      
      self.ball = ball
      local fType = SimpleSportMod.getFType(item)
      local inv = self.character:getInventory()
      self.targetItem = inv:AddItem(fType)
      self.character:setPrimaryHandItem(self.targetItem)
      ISRemoveItemTool.removeItem(item, self.character:getPlayerNum())
      
      self:forceComplete()
   end
end

function ISWaitForCatchAction:perform()
--[[    if self.targetItem then
      local item = self.targetItem
      item:getWorldItem():removeFromSquare()
      self.character:getInventory():AddItem(item)
      self.character:setPrimaryHandItem(item)
   end ]]
   SimpleSportMod.clearCatchVar()
   ISBaseTimedAction.perform(self)
end

function ISWaitForCatchAction:animEvent(event, parameter)
   if event == 'waitFinished' then
      self:forceStop()
   end
end

function ISWaitForCatchAction:forceStop()
   SimpleSportMod.clearCatchVar()
   ISBaseTimedAction.stop(self)
end

function ISWaitForCatchAction:stop()
   SimpleSportMod.clearCatchVar()
   ISBaseTimedAction.stop(self)
end

function ISWaitForCatchAction:new(character)
   local o = ISBaseTimedAction.new(self, character)
   o.character = character
   o.targetItem = nil
   local t = SandboxVars.SimpleSportMod.CatchWindow or 3
   o.maxTime = t * 300
   o.stopOnWalk = true
   o.stopOnAim = true
   o.stopOnRun = true
   return o
end
