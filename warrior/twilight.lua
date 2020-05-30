-- Init
chat_types = { "SAY", "YELL", "PARTY", "GUILD", "RAID" }
languages = { "chinese", "english" }

aura_env.player_name = GetUnitName("player", false)
aura_env.damage = 0
aura_env.count = 0
aura_env.start_time = 0
aura_env.chat_type = chat_types[aura_env.config["chat_type"]]
aura_env.language = languages[aura_env.config["language"]]

if aura_env.language == "chinese" then
    aura_env.chat_cast_success = "开炮！！！"
    aura_env.chat_report_1 = " -> 击中"
    aura_env.chat_report_2 = "个目标， 造成伤害："
    aura_env.chat_unit_scale = 0.0001
    aura_env.chat_unit = "万"
else
    aura_env.chat_cast_success = "Fire all!!!"
    aura_env.chat_report_1 = " -> Attacked "
    aura_env.chat_report_2 = "targets, Damage: "
    aura_env.chat_unit_scale = 0.001
    aura_env.chat_unit = "K"
end

-- Trigger
function()
    local timestamp, event, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId, spellName, _, a15 = CombatLogGetCurrentEventInfo()
    if event == "SPELL_DAMAGE" and sourceName == aura_env.player_name and spellId == 317159 then
        if aura_env.count == 0 then
            SendChatMessage(aura_env.chat_cast_success , aura_env.chat_type)
            aura_env.start_time = timestamp
            aura_env.spellName = spellName
        end
        aura_env.count = aura_env.count + 1
        aura_env.damage = aura_env.damage + a15
    elseif aura_env.count > 0 and (timestamp - aura_env.start_time) > 2 then
        if aura_env.damage > 0 then
            SendChatMessage(aura_env.spellName .. aura_env.chat_report_1 .. aura_env.count .. aura_env.chat_report_2 .. string.format("%.1f", aura_env.damage * aura_env.chat_unit_scale) .. aura_env.chat_unit , aura_env.chat_type)
        end
        aura_env.count = 0
        aura_env.damage = 0
    end
end
