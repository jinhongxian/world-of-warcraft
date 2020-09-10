------------------------------------------------
-- 误导
-- Create the macro to use
aura_env.macro_1_text = [[
/cast [nocombat] !假死
/cast [nocombat] !伪装
/cleartarget
/targetenemy
]]
aura_env.macro_2_text = [[
/cast 奥术射击
]]
local clean_yard = clean_yard or CreateFrame("Button", "clean_yard", UIParent, "SecureActionButtonTemplate")
clean_yard:SetAttribute("type", "macro") 
clean_yard:SetAttribute("macrotext", aura_env.macro_1_text)

-- UNIT_TARGET
function(table,event,unit)
    if unit == "player" then
        local guid, name = UnitGUID("target"), UnitName("target")
        print(unit, guid, name)
        local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
        if type == "Creature" and name == "耸角雄鹿" then 
            clean_yard:SetAttribute("macrotext", aura_env.macro_2_text)
        elseif type == "Vehicle" and name == "灰鬃熊" then
            clean_yard:SetAttribute("macrotext", aura_env.macro_2_text)
        else
            clean_yard:SetAttribute("macrotext", aura_env.macro_1_text)
        end
    end
end