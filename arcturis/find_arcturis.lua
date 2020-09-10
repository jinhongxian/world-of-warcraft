-- Create the macro to use

aura_env.macro_text = [[
/cleartarget
/targetenemy
]]

local find_arcturis = find_arcturis or CreateFrame("Button", "find_arcturis", UIParent, "SecureActionButtonTemplate")
find_arcturis:SetAttribute("type", "macro") 
find_arcturis:SetAttribute("macrotext", aura_env.macro_text)



-- UNIT_TARGET
function(table,event,unit)
    if unit == "player" then
        local guid, name = UnitGUID("target"), UnitName("target")
        local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid);
        if type == "Creature" then 
            if name == "阿克图瑞斯" then
                print("==> ",guid,name)
                find_arcturis:Disable()
            else
                print(guid,name)
                find_arcturis:Enable()
            end
        end
    end
end

-- Macro
/click find_arcturis