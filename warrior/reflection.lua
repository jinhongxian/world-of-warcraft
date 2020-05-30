-- Init
aura_env.player_name = GetUnitName("player", false)
chat_types = { "SAY", "YELL", "PARTY", "GUILD", "RAID" }
aura_env.char_type = chat_types[aura_env.config["chat_type"]]
if aura_env.config["language"] == "chinese" then
    aura_env.chat_cast_success = "开启盾反！"
    aura_env.chat_report_1 = "盾反："
    aura_env.chat_report_2 = " 伤害："
    aura_env.chat_unit_scale = 0.0001
    aura_env.chat_unit = "万"
else
    aura_env.chat_cast_success = "Cast Spell Reflection!"
    aura_env.chat_report_1 = "Reflect: "
    aura_env.chat_report_2 = " Damage: "
    aura_env.chat_unit_scale = 0.001
    aura_env.chat_unit = "K"
end

-- Trigger
function()
    local timestamp, event, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId, spellName, _, a15 = CombatLogGetCurrentEventInfo()
    if spellId == 23920 and event == "SPELL_CAST_SUCCESS" and sourceName == aura_env.player_name then
        SendChatMessage(aura_env.cast_success, aura_env.char_type)
        aura_env.reflect_spellIds = {}
    elseif a15 == "REFLECT" and event == "SPELL_MISSED" and destName == aura_env.player_name then
        aura_env.reflect_spellIds[spellId] = true
    elseif sourceGUID == destGUID and event == "SPELL_DAMAGE" then
        if aura_env.reflect_spellIds[spellId] then
            link = GetSpellLink(spellId)
            SendChatMessage(aura_env.chat_report_1 .. sourceName .." " .. link .. aura_env.chat_report_2 .. string.format("%.1f",  a15 * aura_env.chat_unit_scale) .. aura_env.chat_unit, aura_env.char_type)
        end
    end
end