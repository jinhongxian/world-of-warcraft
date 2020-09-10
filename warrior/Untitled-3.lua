-- Event
COMBAT_LOG_EVENT_UNFILTERED
-- Actions Init Custom
aura_env.player_name=GetUnitName("player", false)


-- Trigger
function()
    local timestamp, eventType, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags,a12,a13,a14,a15,a16,a17,a18,a19,a20 = CombatLogGetCurrentEventInfo(); -- Those arguments appear for all combat event variants.
    local eventPrefix, eventSuffix = eventType:match("^(.-)_?([^_]*)$");
    --print(dstFlags, dstFlags2,a12,a13,a14,a15,a16,a17,a18,a19,a20);
    if  UnitAffectingCombat("player") and  (eventPrefix:match("^SPELL") or eventPrefix:match("^RANGE")) and eventSuffix == "DAMAGE" and srcName == "卢伽尔班达" and a13 == "暮光毁灭" then
        print(eventType, hideCaster, srcGUID, srcName, srcFlags, srcFlags2, dstGUID, dstName, dstFlags, dstFlags2,a12,a13,a14,a15,a16,a17,a18,a19,a20)
        print("==================")
        aura_env.damage = aura_env.damage + a15;
        print(aura_env.damage)
        print(aura_env.state)
        return true
    end
    return false
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
    end
end



function(_filter,_timestamp,_event,...)
    if aura_env.count > 0 and (_timestamp - aura_env.start_time) > 2 then
        if aura_env.damage > 0 then
            SendChatMessage(aura_env.player_name .. "的暮光炮，击中了" ..aura_env.count .."个目标，打出了" .. string.format("%.1f", aura_env.damage * 0.0001) .. "万的伤害！！！" ,"YELL")
        else
            SendChatMessage(aura_env.player_name .. "的暮光炮打偏了！！！" ,"YELL")
        end
        aura_env.count = 0;
        aura_env.damage = 0;
    end
end
------------
aura_env.player_name=GetUnitName("player", false)
aura_env.damage = 0;
aura_env.count = 0;



SendChatMessage("暮光炮打出了万的伤害！！！" ,"YELL")


aura_env.reset = false;
aura_env.damage = 0;
aura_env.count = 0;
aura_env.start_time = 0;
aura_env.end_time  = 0;

aura_env.player_name=GetUnitName("player", false);
print(aura_env.player_name);




function(_filter,_timestamp,_event)
    local timestamp, eventType, hideCaster, srcGUID, srcName, srcFlags, srcFlags2, dstGUID, dstName, dstFlags, dstFlags2, a12, a13, a14, a15, a16, a17, a18, a19, a20 = CombatLogGetCurrentEventInfo()
    if  srcName == GetUnitName("player", false) then
        print(eventType, hideCaster, srcGUID, srcName, srcFlags, srcFlags2, dstGUID, dstName, dstFlags, dstFlags2, a12, a13, a14, a15, a16, a17, a18, a19, a20)
    end
end






function()
    local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, a15, a16,a17,a18,a19,a20, a21, a22, a23, a24, a25 = CombatLogGetCurrentEventInfo()
    if not aura_env.reflect_success and event == "SPELL_MISSED" and destName == aura_env.player_name and a15 == "REFLECT" then
        aura_env.reflect_success = true
        aura_env.reflect_targetId = sourceGUID
        aura_env.reflect_spellId = spellId
        --print(aura_env.reflect_targetId,aura_env.reflect_spellId)
        return
    end

    -- 成功盾反条件
    -- 1.找到REFLECT事件，并记录施法者和法术ID
    -- 2.找到SPELL_DAMAGE事件
    -- 3.相同的施法者
    -- 4.相同的目标
    -- 5.相同的法术ID
    if aura_env.reflect_success and event == "SPELL_DAMAGE" then
        if aura_env.reflect_targetId == sourceGUID and aura_env.reflect_targetId == destGUID and aura_env.reflect_spellId == spellId then
            link = GetSpellLink(spellId)
            SendChatMessage("成功盾反"..sourceName .."的" .. link .."，并造成伤害：" .. a15,"YELL")
            aura_env.reflect_success = false
        end
    end
end


function()
    local timestamp, eventType, hideCaster, srcGUID, srcName, srcFlags, srcFlags2, dstGUID, dstName, dstFlags, dstFlags2,a12,a13,a14,a15,a16,a17,a18,a19,a20 = CombatLogGetCurrentEventInfo(); -- Those arguments appear for all combat event variants.
    if srcName == "卢伽尔班达"  then
        print(eventType, hideCaster, srcGUID, srcName, srcFlags, srcFlags2, dstGUID, dstName, dstFlags, dstFlags2,a12,a13,a14,a15,a16,a17,a18,a19,a20);
    elseif srcName == "铁潮塑浪者" then 
            print(eventType, hideCaster, srcGUID, srcName, srcFlags, srcFlags2, dstGUID, dstName, dstFlags, dstFlags2,a12,a13,a14,a15,a16,a17,a18,a19,a20);
    end
end

link = GetSpellLink(spellId)

GetSpellLink(23920)

SendChatMessage("技能" .. GetSpellLink(23920) ,"YELL") 



function()
    local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, a15, a16,a17,a18,a19,a20, a21, a22, a23, a24, a25 = CombatLogGetCurrentEventInfo()
    
    if spellId == 23920 and event == "SPELL_CAST_SUCCESS" then
        -- 盾反开启
        SendChatMessage("开启盾反", aura_env.char_type)
        
    elseif a15 == "REFLECT" and event == "SPELL_MISSED" and destName == aura_env.player_name then
        -- 成功盾反
        aura_env.reflect_spellId = spellId
        
    elseif event == "SPELL_DAMAGE" then
        -- 造成伤害
        if sourceGUID == destGUID then
            if aura_env.reflect_spellId == spellId then
                link = GetSpellLink(spellId)
                SendChatMessage("盾反: "..sourceName .." " .. link .." 伤害：" .. string.format("%.1f",  a15 * 0.0001) .."万", aura_env.char_type)
            end
        end
    end
end