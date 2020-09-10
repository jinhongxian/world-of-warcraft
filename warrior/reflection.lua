-- Init
chat_types = { "SAY", "YELL", "PARTY", "GUILD", "RAID", "EMOTE" }
languages = { "chinese", "english" }

aura_env.player_name = GetUnitName("player", false)
aura_env.chat_type = chat_types[aura_env.config["chat_type"]]
aura_env.language = languages[aura_env.config["language"]]

if aura_env.language == "chinese" then
    aura_env.chat_cast_success = "开启盾反！"
    aura_env.chat_report_1 = "盾反："
    aura_env.chat_report_2 = " 伤害："
    aura_env.chat_report_3 = " 周期伤害："
    aura_env.chat_unit_scale = 0.0001
    aura_env.chat_unit = "万"
else
    aura_env.chat_cast_success = "Spell Reflection!"
    aura_env.chat_report_1 = "Reflect: "
    aura_env.chat_report_2 = " Damage: "
    aura_env.chat_report_3 = " Periodic Damage: "
    aura_env.chat_unit_scale = 0.001
    aura_env.chat_unit = "K"
end

-- Trigger v1
function()
    local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, a15, a16,a17,a18,a19,a20, a21, a22, a23, a24, a25 = CombatLogGetCurrentEventInfo()

    if event == "SPELL_CAST_SUCCESS" and spellId == 23920 then
        SendChatMessage(aura_env.chat_cast_success, aura_env.char_type)
    elseif event == "SPELL_MISSED" and destName == aura_env.player_name and a15 == "REFLECT" then
        aura_env.reflect_spellId = spellId
    elseif event == "SPELL_DAMAGE" then
        if sourceGUID == destGUID then
            if aura_env.reflect_spellId == spellId then
                link = GetSpellLink(spellId)
                SendChatMessage(aura_env.chat_report_1 .. sourceName .." " .. link .. aura_env.chat_report_2 .. string.format("%.1f",  a15 * aura_env.chat_unit_scale) .. aura_env.chat_unit, aura_env.chat_type)
            end
        end
    end
end


-- Trigger v2
function()
    local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, a15, a16,a17,a18,a19,a20, a21, a22, a23, a24, a25 = CombatLogGetCurrentEventInfo()
    
    if event == "SPELL_CAST_SUCCESS" and spellId == 23920 then
        SendChatMessage(aura_env.chat_cast_success, "YELL")
    elseif event == "SPELL_MISSED" and destName == aura_env.player_name and a15 == "REFLECT" then
        aura_env.reflect_sourceId = sourceGUID
        aura_env.reflect_spellId = spellId
        link = GetSpellLink(spellId)
        SendChatMessage(aura_env.chat_report_1 .. sourceName .." " .. link, "YELL")
    elseif event == "SPELL_DAMAGE" and aura_env.reflect_sourceId == sourceGUID and aura_env.reflect_sourceId == destGUID and aura_env.reflect_spellId == spellId then
        link = GetSpellLink(spellId)
        SendChatMessage(aura_env.chat_report_2 .. string.format("%.1f",  a15 * aura_env.chat_unit_scale) .. aura_env.chat_unit, aura_env.chat_type)
    elseif event == "SPELL_PERIODIC_DAMAGE" and aura_env.reflect_sourceId == sourceGUID and aura_env.reflect_sourceId == destGUID and aura_env.reflect_spellId == spellId then
        link = GetSpellLink(spellId)
        SendChatMessage(aura_env.chat_report_3 .. string.format("%.1f",  a15 * aura_env.chat_unit_scale) .. aura_env.chat_unit, aura_env.chat_type)
    end
end

