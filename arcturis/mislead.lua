-- 误导
-- Create the macro to use
aura_env.macro_FindTarget = [[
/targetenemy
/cast 荣誉旗帜
]]
local FindTarget = FindTarget or CreateFrame("Button", "FindTarget", UIParent, "SecureActionButtonTemplate")
FindTarget:SetAttribute("type", "macro") 
FindTarget:SetAttribute("macrotext", aura_env.macro_FindTarget)

aura_env.party_client = "party2"
aura_env.macro_MisleadToClient = string.format([[
/cast [@%s] 误导
/stopattack
/cast 反制射击
/stopattack
/cast 狂怒战鼓
]],aura_env.party_client)
local MisleadToClient = MisleadToClient or CreateFrame("Button", "MisleadToClient", UIParent, "SecureActionButtonTemplate")
MisleadToClient:SetAttribute("type", "macro") 
MisleadToClient:SetAttribute("macrotext", aura_env.macro_MisleadToClient)
MisleadToClient:Disable()

aura_env.macro_CleanYard = [[
/cast 奥术射击
/cast 猎豹守护
]]
local CleanYard = clean_yard or CreateFrame("Button", "CleanYard", UIParent, "SecureActionButtonTemplate")
CleanYard:SetAttribute("type", "macro") 
CleanYard:SetAttribute("macrotext", aura_env.macro_CleanYard)
CleanYard:Disable()


-- UNIT_TARGET
function(table,event,unit)
    print(event,unit)
    if unit == "player" then
        local name = UnitName("target")
        if name == "阿克图瑞斯" then
            print(event,unit,name)
            FindTarget:Disable()
            MisleadToClient:Enable()
        elseif name == "耸角雄鹿" or name == "灰鬃熊" then 
            FindTarget:Disable()
            CleanYard:Enable()
        end
    end
end


if UnitIsDead("target") or not UnitExists("target") then
    MisleadToClient:Disable()
    CleanYard:Disable()
    FindTarget:Enable()
end

macro = [[
/run AcceptDuel()
/click FindTarget
/click CleanYard
/click MisleadToClient
]]

------------------------------------------------------
if not UnitAffectingCombat("player") then
    tame_beast:SetAttribute("macrotext", aura_env.macro_1_text)
end
local guid, name = UnitGUID("target"), UnitName("target")
local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
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


-- 重置探索敌对目标
-- COMBAT_LOG_EVENT_UNFILTERED
function(event, ...)
    if UnitIsDead("target") or not UnitExists("target") then
        MisleadToClient:Disable()
        CleanYard:Disable()
        FindTarget:Enable() 
    end
end

local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
local spellId, spellName, spellSchool = select(12, ...)
if subevent == "SPELL_CAST_SUCCESS" and sourceName == aura_env.plater_name and spellName == "狂怒战鼓" then
    mislead:SetAttribute("macrotext", aura_env.macro_1_text)
end



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
        MisleadToClient:Disable()
        CleanYard:Disable()
        FindTarget:Enable()
    end
    local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
	local spellId, spellName, spellSchool = select(12, ...)
	if subevent == "SPELL_CAST_SUCCESS" and sourceName == aura_env.plater_name and spellName == "冰冻陷阱" then
        wana:SetAttribute("macrotext", aura_env.macro_2_text)
    end
    if subevent == "SPELL_CAST_SUCCESS" and sourceName == aura_env.plater_name and spellName == "狂怒战鼓" then
        mislead:SetAttribute("macrotext", aura_env.macro_1_text)
    end
end