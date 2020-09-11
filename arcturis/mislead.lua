-- 误导
-- Create the macro to use
aura_env.beast = "阿克图瑞斯"
aura_env.party_client = "party2"
aura_env.macro_1_text = [[
/run AcceptDuel()
/targetenemy
/cast [nocombat] !假死
]]

aura_env.macro_2_text = string.format([[
/run AcceptDuel()
/cast [@%s] 误导
/stopattack
/cast 反制射击
/stopattack
/cast 狂怒战鼓
]],aura_env.party_client)

local mislead = mislead or CreateFrame("Button", "mislead", UIParent, "SecureActionButtonTemplate")
mislead:SetAttribute("type", "macro") 
mislead:SetAttribute("macrotext", aura_env.macro_1_text)

-- UNIT_TARGET
function(table,event,unit)
    if unit == "player" then
        local guid, name = UnitGUID("target"), UnitName("target")
        local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
        if type == "Creature" and name == aura_env.beast then
            print(unit,guid, name)
            mislead:SetAttribute("macrotext", aura_env.macro_2_text)
            return
        end
    end
    if not UnitAffectingCombat("player") then
        tame_beast:SetAttribute("macrotext", aura_env.macro_1_text)
    end
end

------------------------------------------------
-- 英勇
-- Create the macro to use
aura_env.plater_name = UnitName("player")
-- party1target
aura_env.party_client = "party2"
aura_env.macro_1_text = string.format([[
/cast [@%s] 误导
/stopattack
/cast 反制射击
/stopattack
/cast 震荡射击
]],aura_env.party_client)
-- COMBAT_LOG_EVENT_UNFILTERED 
function(event, ...)
	local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
	local spellId, spellName, spellSchool = select(12, ...)
	if subevent == "SPELL_CAST_SUCCESS" and sourceName == aura_env.plater_name and spellName == "狂怒战鼓" then
        mislead:SetAttribute("macrotext", aura_env.macro_1_text)
    end
end

9/9 13:53:40.030  SPELL_CAST_SUCCESS,Player-916-0398D8AF,"兰樱莲雪梅-暗影之月",0x518,0x0,0000000000000000,nil,0x80000000,0x80000000,178207,"狂怒战鼓",0x8,0000000000000000,0000000000000000,0,0,0,0,0,0,-1,0,0,0,0.00,0.00,116,0.0000,0
9/9 13:54:19.995  SPELL_AURA_REMOVED,Player-916-0398D8AF,"兰樱莲雪梅-暗影之月",0x518,0x0,Player-916-0398D8AF,"兰樱莲雪梅-暗影之月",0x518,0x0,178207,"狂怒战鼓",0x8,BUFF
