------------------------------------------------
-- 误导
-- Create the macro to use
aura_env.macro_1_text = [[
/run StartDuel("party1")
/targetenemy
/cast 荣誉旗帜
]]

aura_env.macro_2_text = [[
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
]],aura_env.party_client)

local clean_yard = clean_yard or CreateFrame("Button", "clean_yard", UIParent, "SecureActionButtonTemplate")
clean_yard:SetAttribute("type", "macro") 
clean_yard:SetAttribute("macrotext", aura_env.macro_1_text)

-- UNIT_TARGET
function(table,event,unit)
    if unit == "player" then
        local guid, name = UnitGUID("target"), UnitName("target")
        local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
        if type == "Creature" and (name == "耸角雄鹿" or name == "灰鬃熊")then 
            clean_yard:SetAttribute("macrotext", aura_env.macro_2_text)

        elseif type == "Creature" and name == "阿克图瑞斯" then
            print(event,guid, name)
            clean_yard:SetAttribute("macrotext", aura_env.macro_3_text)
        else
            clean_yard:SetAttribute("macrotext", aura_env.macro_1_text)
        end
    end
end


-- 陷阱
-- Create the macro to use
aura_env.macro_Wana = [[
/cast [@cursor] 冰冻陷阱
]]
local Wana = Wana or CreateFrame("Button", "Wana", UIParent, "SecureActionButtonTemplate")
Wana:SetAttribute("type", "macro") 
Wana:SetAttribute("macrotext", aura_env.macro_Wana)
Wana:Disable()

aura_env.macro_Duel = [[
/run StartDuel("party3")
/cast 荣誉旗帜
]]
local Duel = Duel or CreateFrame("Button", "Duel", UIParent, "SecureActionButtonTemplate")
Duel:SetAttribute("type", "macro") 
Duel:SetAttribute("macrotext", aura_env.macro_Duel)

--NAME_PLATE_UNIT_ADDED
--NAME_PLATE_UNIT_REMOVED
function(event,nameplate)
    local guid, name = UnitGUID(nameplate), UnitName(nameplate)
    local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
    if type == "Creature" and name == "阿克图瑞斯" then 
        if event == "NAME_PLATE_UNIT_ADDED" then
            print(event,guid, name)
            Wana:Enable()
        else
            Wana:Disable()
        end
    end
end

macro = [[
/click Duel
/click Wana
]]

-- Create the macro to use
aura_env.macro_1_text = [[
/run StartDuel("party1")
/targetenemy
/cast 荣誉旗帜
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