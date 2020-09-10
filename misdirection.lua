------------------------------------------------
-- 误导
-- Create the macro to use
aura_env.macro_nocombat_text = [[
/cast [nocombat] !假死
/cast [nocombat] !伪装
]]
aura_env.macro_threat_text = [[
/target party4target
/cast [@party3] 误导
/cast 反制射击
/castsequence reset=600 稳固射击, 狂怒战鼓, 稳固射击, 稳固射击
]]
local anti_shoot = anti_shoot or CreateFrame("Button", "anti_shoot", UIParent, "SecureActionButtonTemplate")
anti_shoot:SetAttribute("type", "macro") 
anti_shoot:SetAttribute("macrotext", aura_env.macro_nocombat_text)

-- UNIT_TARGET
function(table,event,unit)
    if unit == "party4" then
        local guid, name = UnitGUID("target"), UnitName("target")
        print(unit, guid, name)
        local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
        if type == "Creature" then 
            if name == "阿克图瑞斯" then
                print("---------->")
                anti_shoot:SetAttribute("macrotext", aura_env.macro_threat_text)
            else
                anti_shoot:SetAttribute("macrotext", aura_env.macro_nocombat_text)
            end
        end
    end
end

------------------------------------------------
-- 英勇
-- Create the macro to use
aura_env.macro_threat_text = [[
/target party4target
/cast [@party3] 误导
/cast 反制射击
/cast 稳固射击
]]

-- COMBAT_LOG_EVENT_UNFILTERED 
function(event, ...)
	local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
	local spellId, spellName, spellSchool = select(12, ...)
    local playerName = "Micarelli"
	if subevent == "SPELL_CAST_SUCCESS" and sourceName == playerName and spellName == "狂怒战鼓" then
        print("----------> Fire Mode")
        anti_shoot:SetAttribute("macrotext", aura_env.macro_threat_text)
    end
end

9/9 13:53:40.030  SPELL_CAST_SUCCESS,Player-916-0398D8AF,"兰樱莲雪梅-暗影之月",0x518,0x0,0000000000000000,nil,0x80000000,0x80000000,178207,"狂怒战鼓",0x8,0000000000000000,0000000000000000,0,0,0,0,0,0,-1,0,0,0,0.00,0.00,116,0.0000,0
9/9 13:54:19.995  SPELL_AURA_REMOVED,Player-916-0398D8AF,"兰樱莲雪梅-暗影之月",0x518,0x0,Player-916-0398D8AF,"兰樱莲雪梅-暗影之月",0x518,0x0,178207,"狂怒战鼓",0x8,BUFF
