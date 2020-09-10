local FirstTime = 0
local FirstTime_ = 0
local chuxu = 0

local player1 = GetUnitName("player",true)
local zmhx = 0
local fhzy = 0
local tlcx = 0
local bkyydzx = 0 
local sum = 0
local flag = 0
local i = 0
local sum_ = 0
local flag_ = 0
local j = 0

local eventSwitch = {
	["SPELL_AURA_APPLIED"] = true,
	["SPELL_AURA_REMOVED"] = true,
	["SPELL_AURA_REFRESH"] = true,
	["SPELL_AURA_APPLIED_DOSE"] = true,
	["SPELL_AURA_APPLIED_REMOVED_DOSE"] = true,
	["SPELL_AURA_REMOVED_DOSE"] = true,
	["SPELL_AURA_BROKEN"] = true,
	["SPELL_AURA_BROKEN_SPELL"] = true,
	["ENCHANT_REMOVED"] = true,
	["ENCHANT_APPLIED"] = true,
	["SPELL_CAST_SUCCESS"] = true,
	["SPELL_PERIODIC_ENERGIZE"] = true,
	["SPELL_ENERGIZE"] = true,
	["SPELL_PERIODIC_HEAL"] = true,
	["SPELL_HEAL"] = true,
	["SPELL_DAMAGE"] = true,
	["SPELL_PERIODIC_DAMAGE"] = true,
	--added new
	["SPELL_DRAIN"] = true,
	["SPELL_LEECH"] = true,
	["SPELL_PERIODIC_DRAIN"] = true,
	["SPELL_PERIODIC_LEECH"] = true,
	["DAMAGE_SHIELD"] = true,
	["DAMAGE_SPLIT"] = true,
}

local lrnFrame = CreateFrame("Frame", "lrnFrame")
lrnFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")


lrnFrame:SetScript("OnEvent", function(self, event_name, ...)
	if self[event_name] then
		return self[event_name](self, event_name, ...)
	end
end)

function lrnprint(messages)

	if true then
		C_ChatInfo.SendAddonMessage(messages,"YELL")
	else
		print(messages)
	end
end

function lrnFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, aAmount)
	if srcName == player1 and spellId == 317159 then --317159
		sum = sum + aAmount
		i = i + 1
		if flag == 0 then 
			FirstTime = timestamp
			flag =1
		end

    elseif srcName == player1 and spellId == 317265 then
		RaidNotice_AddMessage(RaidWarningFrame,"无尽之星 "..string.format("%.1f", aAmount*0.0001).."万！", {r=255,g=255,b=0})
        

    elseif srcName == player1 and spellId == 317291 then --317159
		sum_ = sum_ + aAmount
		j = j + 1
		if flag_ == 0 then 
			FirstTime_ = timestamp
			flag_ =1
		end	    
    end

	if timestamp - FirstTime > 2 and flag == 1 then
		flag = 0
		RaidNotice_AddMessage(RaidWarningFrame,"暮光炮"..string.format("%.d",i ).."杀，打出了" ..string.format("%.1f", sum*0.0001).."万的伤害！！！", {r=255,g=255,b=0})
		if i == 1 then
		PlaySoundFile("Interface/AddOns/NZothServant/1kill.ogg")
		sum = 0
		i = 0
		elseif i == 2 then
		PlaySoundFile("Interface/AddOns/NZothServant/2kill.ogg")
		sum = 0
		i = 0
		elseif i == 3 then
		PlaySoundFile("Interface/AddOns/NZothServant/3kill.ogg")
		sum = 0
		i = 0
		elseif i == 4 then
		PlaySoundFile("Interface/AddOns/NZothServant/4kill.ogg")
		sum = 0
		i = 0
		elseif i == 5 then
		PlaySoundFile("Interface/AddOns/NZothServant/5kill.ogg")
		sum = 0
		i = 0
		elseif i == 6 then
		PlaySoundFile("Interface/AddOns/NZothServant/6kill.ogg")
		sum = 0
		i = 0
		elseif i == 7 then
		PlaySoundFile("Interface/AddOns/NZothServant/7kill.ogg")
		sum = 0
		i = 0
		elseif i == 8 then
		PlaySoundFile("Interface/AddOns/NZothServant/8kill.ogg")
		sum = 0
		i = 0
		elseif i == 9 then
		PlaySoundFile("Interface/AddOns/NZothServant/9kill.ogg")
		sum = 0
		i = 0
		elseif i > 9 then
		PlaySoundFile("Interface/AddOns/NZothServant/10kill.ogg")
		sum = 0
		i = 0
		end
	elseif timestamp - FirstTime_ > 1 and flag_ == 1 then
		flag_ = 0
		RaidNotice_AddMessage(RaidWarningFrame,"虚空鞭笞"..string.format("%.d",j ).."杀，打出了" ..string.format("%.1f", sum_*0.0001).."万的伤害！！！", {r=255,g=255,b=0})
		if j == 1 then
		PlaySoundFile("Interface/AddOns/NZothServant/1kill.ogg")
		sum = 0
		j = 0
		elseif j == 2 then
		PlaySoundFile("Interface/AddOns/NZothServant/2kill.ogg")
		sum = 0
		j = 0
		elseif j == 3 then
		PlaySoundFile("Interface/AddOns/NZothServant/3kill.ogg")
		sum = 0
		j = 0
		elseif j == 4 then
		PlaySoundFile("Interface/AddOns/NZothServant/4kill.ogg")
		sum = 0
		j = 0
		elseif j == 5 then
		PlaySoundFile("Interface/AddOns/NZothServant/5kill.ogg")
		sum = 0
		j = 0
		elseif j == 6 then
		PlaySoundFile("Interface/AddOns/NZothServant/6kill.ogg")
		sum = 0
		j = 0
		elseif j == 7 then
		PlaySoundFile("Interface/AddOns/NZothServant/7kill.ogg")
		sum = 0
		j = 0
		elseif j == 8 then
		PlaySoundFile("Interface/AddOns/NZothServant/8kill.ogg")
		sum = 0
		j = 0
		elseif j == 9 then
		PlaySoundFile("Interface/AddOns/NZothServant/9kill.ogg")
		sum = 0
		j = 0
		elseif j > 9 then
		PlaySoundFile("Interface/AddOns/NZothServant/10kill.ogg")
		sum = 0
		j = 0
		end
	end
end



function lrnFrame:COMBAT_LOG_EVENT_UNFILTERED(event,...)

	local timestamp, eventType, hideCaster, srcGUID, srcName, srcFlags, srcFlags2, dstGUID, dstName, dstFlags, dstFlags2,a12,a13,a14,a15,a16,a17,a18,a19,a20 = CombatLogGetCurrentEventInfo(); -- Those arguments appear for all combat event variants.
	local eventPrefix, eventSuffix = eventType:match("^(.-)_?([^_]*)$");
	--print(dstFlags, dstFlags2,a12,a13,a14,a15,a16,a17,a18,a19,a20)

	if (eventPrefix:match("^SPELL") or eventPrefix:match("^RANGE")) and eventSuffix == "DAMAGE" then
		local spellId, spellName, spellSchool, sAmount, aOverkill, sSchool, sResisted, sBlocked, sAbsorbed, sCritical, sGlancing, sCrushing, sOffhand, _ = select(12,CombatLogGetCurrentEventInfo())
		lrnFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, sAmount)
	elseif eventPrefix:match("^SPELL") and eventSuffix == "MISSED" then
		local spellId, spellName, spellSchool, missType, isOffHand, mAmount  = select(12,CombatLogGetCurrentEventInfo())
		if mAmount then
			lrnFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, mAmount)
		end
	end
end