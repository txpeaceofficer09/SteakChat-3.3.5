--local addon = CreateFrame("Frame")
--addon:RegisterEvent("PLAYER_LOGIN")
--addon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

local logFrame

-- class-colored names
local function ColorName(name, guid)
    if not name then return "?" end
    local _, class = GetPlayerInfoByGUID(guid)
    if class and RAID_CLASS_COLORS[class] then
        local c = RAID_CLASS_COLORS[class]
        return string.format("|cff%02x%02x%02x%s|r",
            c.r * 255, c.g * 255, c.b * 255, name)
    end
    return name
end

-- spell icon
local function SpellIcon(spellID)
    if not spellID then return "" end
    local icon = select(3, GetSpellInfo(spellID))
    return icon and ("|T"..icon..":14:14:0:0|t") or ""
end

-- colored amount
local function ColorAmount(amount, kind)
    if not amount then return "" end
    if kind == "DAMAGE" then
        return string.format("|cffff3333%d|r", amount)   -- red
    elseif kind == "HEAL" then
        return string.format("|cff33ff33%d|r", amount)   -- green
    elseif kind == "ABSORB" then
        return string.format("|cffffff33%d|r", amount)   -- yellow
    elseif kind == "BUFF" then
        return string.format("|cff3399ff%d|r", amount)   -- blue
    end
    return tostring(amount)
end

local function LogEvent(srcGUID, srcName, spellID, spellName, amount, dstGUID, dstName, kind)
	if not logFrame then return end
	local msg

	if amount then
		msg = string.format("%s %s%s %s %s", ColorName(srcName, srcGUID), SpellIcon(spellID), spellName or "", ColorAmount(amount, kind), ColorName(dstName, dstGUID))
	else
		msg = string.format("%s %s%s %s", ColorName(srcName, srcGUID), SpellIcon(spellID), spellName or "", ColorName(dstName, dstGUID))
	end
    logFrame:AddMessage(msg)
end

local function SetupChatFrame()
    -- reuse Blizzard combat log frame so it’s docked like default
    logFrame = ChatFrame2

    -- rename tab
    FCF_SetWindowName(logFrame, "SteakLog")

    -- stop Blizzard from writing its own combat log spam
    logFrame:UnregisterAllEvents()

    -- basic style
    logFrame:SetMaxLines(500)
    logFrame:SetFading(true)
    logFrame:SetTimeVisible(10)
    logFrame:SetFadeDuration(2)
end

local function OnCombatEvent(...)
    local timestamp, subevent, srcGUID, srcName, _, dstGUID, dstName, _, spellID, spellName = ...

    local amount

    -- =========================
    -- DAMAGE
    -- =========================

    if subevent == "SWING_DAMAGE" then
        amount = select(9, ...)
        LogEvent(srcGUID, srcName, nil, "Melee", amount, dstGUID, dstName, "DAMAGE")

    elseif subevent == "RANGE_DAMAGE" then
        amount = select(12, ...)
        LogEvent(srcGUID, srcName, spellID, spellName, amount, dstGUID, dstName, "DAMAGE")

    elseif subevent == "SPELL_DAMAGE" then
        amount = select(12, ...)
        LogEvent(srcGUID, srcName, spellID, spellName, amount, dstGUID, dstName, "DAMAGE")

    elseif subevent == "SPELL_PERIODIC_DAMAGE" then
        amount = select(12, ...)
        LogEvent(srcGUID, srcName, spellID, spellName.." (DoT)", amount, dstGUID, dstName, "DAMAGE")

    elseif subevent == "DAMAGE_SHIELD" then
        amount = select(12, ...)
        LogEvent(srcGUID, srcName, spellID, spellName.." (Shield)", amount, dstGUID, dstName, "DAMAGE")

    elseif subevent == "DAMAGE_SPLIT" then
        amount = select(12, ...)
        LogEvent(srcGUID, srcName, spellID, spellName.." (Split)", amount, dstGUID, dstName, "DAMAGE")


    -- =========================
    -- HEALING
    -- =========================

    elseif subevent == "SPELL_HEAL" then
        amount = select(12, ...)
        LogEvent(srcGUID, srcName, spellID, spellName, amount, dstGUID, dstName, "HEAL")

    elseif subevent == "SPELL_PERIODIC_HEAL" then
        amount = select(12, ...)
        LogEvent(srcGUID, srcName, spellID, spellName.." (HoT)", amount, dstGUID, dstName, "HEAL")


    -- =========================
    -- ABSORBS
    -- =========================

    elseif subevent == "SPELL_ABSORBED" then
        -- WotLK has two formats:
        -- 1) spellID present
        -- 2) no spellID (swing)
        local n = select("#", ...)
        local absorbed = select(n, ...)
        LogEvent(srcGUID, srcName, spellID, spellName, absorbed, dstGUID, dstName, "ABSORB")


    -- =========================
    -- BUFFS / DEBUFFS
    -- =========================

    elseif subevent == "SPELL_AURA_APPLIED" then
        LogEvent(srcGUID, srcName, spellID, spellName, nil, dstGUID, dstName, "BUFF")

    elseif subevent == "SPELL_AURA_REFRESH" then
        LogEvent(srcGUID, srcName, spellID, spellName.." (ref)", nil, dstGUID, dstName, "BUFF")

    elseif subevent == "SPELL_AURA_REMOVED" then
        LogEvent(srcGUID, srcName, spellID, spellName.." (fade)", nil, dstGUID, dstName, "BUFF")


    -- =========================
    -- MISSES
    -- =========================

    elseif subevent == "SWING_MISSED" then
        local missType = select(9, ...)
        LogEvent(srcGUID, srcName, nil, missType, 0, dstGUID, dstName, "BUFF")

    elseif subevent == "RANGE_MISSED" then
        local missType = select(12, ...)
        LogEvent(srcGUID, srcName, spellID, spellName.." ("..missType..")", 0, dstGUID, dstName, "BUFF")

    elseif subevent == "SPELL_MISSED" then
        local missType = select(12, ...)
        LogEvent(srcGUID, srcName, spellID, spellName.." ("..missType..")", 0, dstGUID, dstName, "BUFF")

    elseif subevent == "SPELL_PERIODIC_MISSED" then
        local missType = select(12, ...)
        LogEvent(srcGUID, srcName, spellID, spellName.." ("..missType..")", 0, dstGUID, dstName, "BUFF")


    -- =========================
    -- ENVIRONMENTAL DAMAGE
    -- =========================

    elseif subevent == "ENVIRONMENTAL_DAMAGE" then
        local envType = spellID -- Blizzard uses spellID field for type
        amount = select(10, ...)
        LogEvent(srcGUID, srcName, nil, envType, amount, dstGUID, dstName, "DAMAGE")
    end
end


--[[
addon:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        SetupChatFrame()
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        OnCombatEvent(...)
    end
end)
]]
