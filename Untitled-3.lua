------------------------------------------------
-- 驯服
-- Create the macro to use
aura_env.macro_nocombat_text = [[
/cast [nocombat] !假死
/cast [nocombat] !伪装
]]
aura_env.macro_threat_text = [[
/target party4target
/cast 反制射击
/cast 驯服野兽
]]
local tame_beast = tame_beast or CreateFrame("Button", "tame_beast", UIParent, "SecureActionButtonTemplate")
tame_beast:SetAttribute("type", "macro") 
tame_beast:SetAttribute("macrotext", aura_env.macro_nocombat_text)

-- UNIT_TARGET
function(table,event,unit)
    if unit == "party4" then
        local guid, name = UnitGUID("target"), UnitName("target")
        print(unit, guid, name)
        local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
        if type == "Creature" and name == "阿克图瑞斯" then
            print("---------->")
            tame_beast:SetAttribute("macrotext", aura_env.macro_threat_text)
        else
            tame_beast:SetAttribute("macrotext", aura_env.macro_nocombat_text)
        end
    end
end