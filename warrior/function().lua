function()
    local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, a15, a16,a17,a18,a19,a20, a21, a22, a23, a24, a25 = CombatLogGetCurrentEventInfo()
    -- 盾反开启
    if event == "SPELL_CAST_SUCCESS" and spellId == 23920 then
        SendChatMessage("盾反已开","YELL")
    -- 成功盾反
    elseif event == "SPELL_MISSED" and destName == aura_env.player_name and a15 == "REFLECT" then
        aura_env.reflect_spellId = spellId
    -- 造成伤害
    elseif event == "SPELL_DAMAGE" then
        if sourceGUID == destGUID then
            if aura_env.reflect_spellId == spellId then
                link = GetSpellLink(spellId)
                SendChatMessage("盾反："..sourceName .." -> " .. link .." 伤害：" .. string.format("%.1f",  a15 * 0.0001) .."万","YELL")
            end
        end
    end
end


function(_filter,_timestamp,_event)
    local timestamp, eventType, hideCaster, srcGUID, srcName, srcFlags, srcFlags2, dstGUID, dstName, dstFlags, dstFlags2, a12, a13, a14, a15, a16, a17, a18, a19, a20 = CombatLogGetCurrentEventInfo()
    if  srcName == aura_env.player_name and eventType == "SPELL_DAMAGE" and a13 == "暮光毁灭" then
        if aura_env.count == 0 then
            aura_env.start_time = timestamp;
        end
        -- 累加计数
        aura_env.count = aura_env.count + 1;
        -- 累加伤害
        aura_env.damage = aura_env.damage + a15
    elseif aura_env.count > 0 and (_timestamp - aura_env.start_time) > 2 then
        if aura_env.damage > 0 then
            SendChatMessage(aura_env.player_name .. "的暮光毁灭击中" ..aura_env.count .."个目标，打出了" .. string.format("%.1f", aura_env.damage * 0.0001) .. "万的伤害！！！" ,"PARTY")
        end
        aura_env.count = 0;
        aura_env.damage = 0;
    end
end

function(_filter,_timestamp,_event,...)
    if aura_env.count > 0 and (_timestamp - aura_env.start_time) > 2 then
        if aura_env.damage > 0 then
            SendChatMessage(aura_env.player_name .. "的暮光炮，击中了" ..aura_env.count .."个目标，打出了" .. string.format("%.1f", aura_env.damage * 0.0001) .. "万的伤害！！！" ,"PARTY")
        else
            SendChatMessage(aura_env.player_name .. "的暮光炮打偏了！！！" ,"PARTY")
        end
        aura_env.count = 0;
        aura_env.damage = 0;
    end
end
