-- 驯服
-- Create the macro to use
aura_env.macro_FindPet = [[
/cast [pet] 解散宠物
/targetenemy
/cast 荣誉旗帜
]]
local FindPet = FindPet or CreateFrame("Button", "FindPet", UIParent, "SecureActionButtonTemplate")
FindPet:SetAttribute("type", "macro") 
FindPet:SetAttribute("macrotext", aura_env.macro_FindPet)


aura_env.macro_TamePet = [[
/cast 荣誉旗帜
/stopattack
/cast 反制射击
/stopattack
/cast [nopet] 驯服野兽
/cast [pet] 解散宠物
]]

local TamePet = TamePet or CreateFrame("Button", "TamePet", UIParent, "SecureActionButtonTemplate")
TamePet:SetAttribute("type", "macro") 
TamePet:SetAttribute("macrotext", aura_env.macro_TamePet)
TamePet:Disable()

-- UNIT_TARGET
function(table,event,unit)
    if unit == "player" then
        local name = UnitName("target")
        if name == "阿克图瑞斯" then
            print(unit, name)
            FindPet:Disable()
            TamePet:Enable()
        end
    end
end

macro = [[
/run AcceptDuel()
/click FindPet
/click TamePet
]]

if not UnitAffectingCombat("player") then
    tame_beast:SetAttribute("macrotext", aura_env.macro_1_text)
end

-- 重置探索敌对目标
-- COMBAT_LOG_EVENT_UNFILTERED
function(event, ...)
    if UnitIsDead("target") or not UnitExists("target") or not UnitCanAttack("player", "target")then
        TamePet:Disable()
        FindPet:Enable() 
    end
end