------------------------------------------------
-- 驯服
-- party1
aura_env.party_finder = "party1"
-- party1target
aura_env.party_finder_target = string.format("%starget",aura_env.party_finder)
-- Create the macro to use
aura_env.macro_nocombat_text = [[
/cast [nocombat] !假死
/cast [nocombat] !伪装
]]
aura_env.macro_tame_text = string.format([[
/target %s
/cast 反制射击
/cast 驯服野兽
]], aura_env.party_finder_target)
local tame_beast = tame_beast or CreateFrame("Button", "tame_beast", UIParent, "SecureActionButtonTemplate")
tame_beast:SetAttribute("type", "macro") 
tame_beast:SetAttribute("macrotext", aura_env.macro_nocombat_text)

-- UNIT_TARGET
function(table,event,unit)
    if unit == aura_env.party_finder then
        local guid, name = UnitGUID(aura_env.party_finder_target), UnitName(aura_env.party_finder_target)
        print(unit, guid, name)
        local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
        if type == "Creature" and name == "阿克图瑞斯" then
            print("---------->")
            tame_beast:SetAttribute("macrotext", aura_env.macro_tame_text)
        else
            tame_beast:SetAttribute("macrotext", aura_env.macro_nocombat_text)
        end
    end
end