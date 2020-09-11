-- 驯服
aura_env.beast = "阿克图瑞斯"
-- Create the macro to use
aura_env.macro_1_text = [[
/cast [pet] 解散宠物
/targetenemy
/cast [nocombat] !假死
/cast [nocombat] !伪装
]]

aura_env.macro_2_text = [[
/stopattack
/cast 反制射击
/stopattack
/cast [nopet] 驯服野兽
/cast [pet] 解散宠物
]]

local tame_beast = tame_beast or CreateFrame("Button", "tame_beast", UIParent, "SecureActionButtonTemplate")
tame_beast:SetAttribute("type", "macro") 
tame_beast:SetAttribute("macrotext", aura_env.macro_1_text)

-- UNIT_TARGET
function(table,event,unit)
    if unit == "player" then
        local guid, name = UnitGUID("target"), UnitName("target")
        local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
        if type == "Creature" and name == aura_env.beast then
            print(unit, guid, name)
            tame_beast:SetAttribute("macrotext", aura_env.macro_2_text)
            return
        end
    end
    if not UnitAffectingCombat("player") then
        tame_beast:SetAttribute("macrotext", aura_env.macro_1_text)
    end
end