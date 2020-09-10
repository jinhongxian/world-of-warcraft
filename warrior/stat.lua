function()
    local output = ""
    
    aura_env.h = string.format("%.2f",GetHaste()).."%"
    aura_env.v = string.format("%.2f",GetCombatRatingBonus(29)).."%"
    aura_env.c = string.format("%.2f",GetCritChance()).."%"
    aura_env.m = string.format("%.2f",GetMasteryEffect()).."%" 
    
    if (GetHaste() or 0) >= 100 then aura_env.hb = " " elseif (GetHaste() or 0) >= 10 then aura_env.hb = "  " else aura_env.hb = "    " end
    if GetCombatRatingBonus(29) >= 100 then aura_env.vb = " " elseif GetCombatRatingBonus(29) >= 10 then aura_env.vb = "  " else aura_env.vb = "    " end
    if GetCritChance() >= 100 then aura_env.cb = " " elseif GetCritChance() >= 10 then aura_env.cb = "  " else aura_env.cb = "    " end
    if GetMasteryEffect() >= 100 then aura_env.mb = " " elseif GetMasteryEffect() >= 10 then aura_env.mb = "  " else aura_env.mb = "    " end
    
    local specID = GetSpecializationInfo(GetSpecialization())
    local val = 0
    local amount = 0
    local primary = 0
    
    
    for k,v in pairs(aura_env.specList) do
        if aura_env.specList[specID] ~= nil then
            primary = aura_env.specList[specID]
            if primary == 1 then
                val = "Str:   "
                amount = UnitStat("player", primary)
            elseif primary == 2 then
                val = "Agi:    "
                amount = UnitStat("player", primary)
            elseif primary == 4 then
                val = "Int:    "
                amount = UnitStat("player", primary)
            else
                val = 0
                amount = 0
            end
        end
    end
    
    if amount >= 10000 then aura_env.pb = " " elseif amount >= 1000 then aura_env.pb = "  " else aura_env.pb = "   " end
    
    if primary > 0 then 
        aura_env.p = val..aura_env.pb..amount.."\
"
    else
        aura_env.p = "Test:     ".."1213".."\
"
    end
    
    aura_env.haste = "|cFFFF7D0AHaste:"..aura_env.hb..aura_env.h
    aura_env.vers = "|cFFFFF569Vers:"..aura_env.vb..aura_env.v
    aura_env.crit = "|cFF40C7EBCrit:"..aura_env.cb..aura_env.c
    aura_env.mast = "|cFF00FF96Mast:"..aura_env.mb..aura_env.m
    output = aura_env.p..aura_env.crit.."\
"..aura_env.haste.."\
"..aura_env.mast.."\
"..aura_env.vers
    
    
    
    return output
end








































