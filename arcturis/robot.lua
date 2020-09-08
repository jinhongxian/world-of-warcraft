--[[
NAME_PLATE_UNIT_ADDED
1. For players: 
    Player-[server ID]-[player UID] 
    (Example: "Player-970-0002FD64")
2. For creatures, pets, objects, and vehicles: 
    [Unit type]-0-[server ID]-[instance ID]-[zone UID]-[ID]-[spawn UID]
    (Example: "Creature-0-970-0-11-31146-000136DF91")
    Unit Type Names: "Creature", "Pet", "GameObject", "Vehicle", and "Vignette"
3. For items: 
    Item-[server ID]-0-[spawn UID] 
    (Example: "Item-970-0-400000076620BFF4") 
]]
function(table,event,namespace)
    local guid, name = UnitGUID(namespace), UnitName(namespace)
    local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
    if type == "Creature" and name == "阿克图瑞斯" then
        print(date(),name,guid)
    end
end

--[[
COMBAT_LOG_EVENT
]]
function(event,...)

end

function(event, ...)
    function parse(guid,name)
        local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
        if type == "Creature" and name == "阿克图瑞斯" then
            return true
        else
            return false
        end
    end

	local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
    
    if parse(sourceGUID,sourceName) or parse(destGUID,destName) then
        print(...)
    end
end


