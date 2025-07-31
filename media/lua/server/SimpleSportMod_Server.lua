

--server
if isClient() then return; end

local Commands = {};
Commands.SimpleSportMod = {};


Commands.SimpleSportMod.DropPoint = function(player, args)
    local playerId = player:getOnlineID();
    sendServerCommand("SimpleSportMod", "DropPoint", {id = playerId, dropPointX =  args.dropPointX, dropPointY =  args.dropPointY, dropPointZ =  args.dropPointZ})
end

Events.OnClientCommand.Add(function(module, command, player, args)
	if Commands[module] and Commands[module][command] then
	    Commands[module][command](player, args)
	end
end)


