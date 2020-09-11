macro = [[
/run StartDuel("party1")
/cast 荣誉旗帜
/click Wana
/cast [@cursor] 冰冻陷阱
]]
-- 陷阱
-- Create the macro to use
aura_env.macro_Wana = [[
/cast [@cursor] 冰冻陷阱
]]
local Wana = Wana or CreateFrame("Button", "Wana", UIParent, "SecureActionButtonTemplate")
Wana:SetAttribute("type", "macro") 
Wana:SetAttribute("macrotext", aura_env.macro_Wana)

--NAME_PLATE_UNIT_ADDED
--NAME_PLATE_UNIT_REMOVED
function(event,nameplate)
    local guid, name = UnitGUID(nameplate), UnitName(nameplate)
    local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
    if type == "Creature" and name == "阿克图瑞斯" and event == "NAME_PLATE_UNIT_ADDED" then 
        print("Wana",event,guid, name)
        Wana:Enable()
        return
    end
    if type == "Creature" and name == "阿克图瑞斯" and event == "NAME_PLATE_UNIT_REMOVED" then
        Wana:Disable()
    end 
end
