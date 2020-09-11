macro = [[
/cast 荣誉旗帜
/click FindTarget
/click MisleadToClient
/click CleanYard
]]
-- 误导
-- Create the macro to use
aura_env.macro_FindTarget = [[
/targetenemy
]]
local FindTarget = FindTarget or CreateFrame("Button", "FindTarget", UIParent, "SecureActionButtonTemplate")
FindTarget:SetAttribute("type", "macro") 
FindTarget:SetAttribute("macrotext", aura_env.macro_FindTarget)

aura_env.macro_MisleadToClient = [[
/cast [@party2] 误导
/stopattack
/cast 反制射击
/stopattack
/cast 狂怒战鼓
]]
local MisleadToClient = MisleadToClient or CreateFrame("Button", "MisleadToClient", UIParent, "SecureActionButtonTemplate")
MisleadToClient:SetAttribute("type", "macro") 
MisleadToClient:SetAttribute("macrotext", aura_env.macro_MisleadToClient)
MisleadToClient:Disable()

aura_env.macro_CleanYard = [[
/cast 奥术射击
]]
local CleanYard = clean_yard or CreateFrame("Button", "CleanYard", UIParent, "SecureActionButtonTemplate")
CleanYard:SetAttribute("type", "macro") 
CleanYard:SetAttribute("macrotext", aura_env.macro_CleanYard)
CleanYard:Disable()


-- UNIT_TARGET
function(table,event,unit)
    if unit == "player" then
        local name = UnitName("target")
        if name == "阿克图瑞斯" then
            FindTarget:Disable()
            MisleadToClient:Enable()
        elseif name == "耸角雄鹿" or name == "灰鬃熊" then 
            FindTarget:Disable()
            CleanYard:Enable()
        end
    end
end

-- 重置探索敌对目标
-- COMBAT_LOG_EVENT_UNFILTERED
function(event, ...)
    if UnitIsDead("target") or not UnitExists("target") or not UnitCanAttack("player", "target") then
        MisleadToClient:Disable()
        CleanYard:Disable()
        FindTarget:Enable() 
    end
end