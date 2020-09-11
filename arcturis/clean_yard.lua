------------------------------------------------
-- 误导
-- Create the macro to use
aura_env.macro_1_text = [[
/run StartDuel("party1")
/targetenemy
/cast [nocombat] !假死
/stopattack
/cast [@focus] 压制
/stopattack
]]

aura_env.macro_2_text = [[
/run StartDuel("party1")
/stopattack
/cast 毒蛇钉刺
/stopattack
]]

aura_env.party_client = "party3"
aura_env.macro_3_text = string.format([[
/run StartDuel("party1")
/cast [@%s] 误导
/stopattack
/cast 反制射击
/stopattack
/cast 震荡射击
]],aura_env.party_client)

local clean_yard = clean_yard or CreateFrame("Button", "clean_yard", UIParent, "SecureActionButtonTemplate")
clean_yard:SetAttribute("type", "macro") 
clean_yard:SetAttribute("macrotext", aura_env.macro_1_text)

-- UNIT_TARGET
function(table,event,unit)
    if unit == "player" then
        local guid, name = UnitGUID("target"), UnitName("target")
        local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
        if type == "Creature" and name == "耸角雄鹿" then 
            clean_yard:SetAttribute("macrotext", aura_env.macro_2_text)
        elseif type == "Vehicle" and name == "灰鬃熊" then
            clean_yard:SetAttribute("macrotext", aura_env.macro_2_text)
        elseif type == "Creature" and name == "阿克图瑞斯" then
            clean_yard:SetAttribute("macrotext", aura_env.macro_3_text)
        else
            clean_yard:SetAttribute("macrotext", aura_env.macro_1_text)
        end
    end
end


-- 陷阱
-- Create the macro to use
aura_env.macro_1_text = [[
]]
aura_env.macro_2_text = [[
/run StartDuel("party1")
/cast [@cursor] 冰冻陷阱
]]
local wana = wana or CreateFrame("Button", "wana", UIParent, "SecureActionButtonTemplate")
wana:SetAttribute("type", "macro") 
wana:SetAttribute("macrotext", aura_env.macro_1_text)
--NAME_PLATE_UNIT_ADDED
function(event,nameplate)
    local guid, name = UnitGUID(nameplate), UnitName(nameplate)
    local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
    if type == "Creature" and name == "阿克图瑞斯" then 
        wana:SetAttribute("macrotext", aura_env.macro_2_text)
    end
end


-- Create the macro to use
aura_env.macro_1_text = [[
/run StartDuel("party1")
/targetenemy
/cast [nocombat] !假死
/stopattack
/cast [@focus] 压制
/stopattack
]]
aura_env.macro_2_text = [[
]]
-- COMBAT_LOG_EVENT_UNFILTERED 
function(event, ...)
	if UnitIsDead("target") or not UnitExists("target") then
        clean_yard:SetAttribute("macrotext", aura_env.macro_1_text)
    end
    local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
	local spellId, spellName, spellSchool = select(12, ...)
	if subevent == "SPELL_CAST_SUCCESS" and sourceName == aura_env.plater_name and spellName == "冰冻陷阱" then
        wana:SetAttribute("macrotext", aura_env.macro_2_text)
    end
end