local f = CreateFrame("Frame", "SteakChatFrame", UIParent)

local _, class = UnitClass("player")
local borderColor = RAID_CLASS_COLORS[class]

local bgFile = "Interface\\ChatFrame\\ChatFrameBackground"
local edgeFile = "Interface\\Buttons\\WHITE8x8"

local expandedHeight = GetScreenHeight() * 0.75
local collapsedHeight = 217

local CHAT_FILTER = {
        "gold",
        "cheap",
        "wts",
        "safe",
        "usd",
        "mmotradinghub"
}

local CHAT_COLORS = {
	CHAT_MSG_SAY = { 1, 1, 1 },
	CHAT_MSG_YELL = { 1, 0.25, 0.25 },
	CHAT_MSG_GUILD = { 0.25, 1, 0.25 },
	CHAT_MSG_GUILD_ACHIEVEMENT = { 1, 1, 0 },
	CHAT_MSG_OFFICER = { 0.25, 0.73, 0.25 },
	CHAT_MSG_PARTY = { 0.6, 0.6, 1 },
	CHAT_MSG_PARTY_LEADER = { 0.4, 0.4, 0.8 },
	CHAT_MSG_RAID = { 1, 0.5, 0 },
	CHAT_MSG_RAID_LEADER = { 1, 0.28, 0 },
	CHAT_MSG_RAID_WARNING = { 1, 0, 0 },
	CHAT_MSG_CHANNEL = { 1, 0.75, 0.75 },
	CHAT_MSG_WHISPER = { 1, 0.4, 0.7 },
	CHAT_MSG_WHISPER_INFORM = { 0.8, 0.2, 0.5 },
	CHAT_MSG_SYSTEM = { 1, 1, 0 },
	CHAT_MSG_EMOTE = { 1, 0.5, 0 },
	CHAT_MSG_TEXT_EMOTE = { 1, 0.5, 0 },
	CHAT_MSG_MONSTER_SAY = { 0.5, 0.5, 0.5 },
	CHAT_MSG_MONSTER_WHISPER = { 1, 0.8, 0 },
	CHAT_MSG_AFK = { 1, 1, 0 },
	CHAT_MSG_DND = { 1, 1, 0 },
	CHAT_MSG_ADDON = { 1, 1, 0 },
	CHAT_MSG_CHANNEL_JOIN = { 1, 0.75, 0.75 },
	CHAT_MSG_CHANNEL_LEAVE = { 1, 0.75, 0.75 },
	CHAT_MSG_BATTLEGROUND = { 1, 0.5, 0 },
	CHAT_MSG_BATTLEGROUND_LEADER = { 1, 0.8, 0.7 },
	CHAT_MSG_LOOT = { 0.5, 0.8, 1 },
	CHAT_MSG_SKILL = { 0.25, 0.75, 1.0 }
}

local CHAT_CHANNEL = {
	CHAT_MSG_SAY = "[S]",
	CHAT_MSG_YELL = "[Y]",
	CHAT_MSG_GUILD = "[G]",
	CHAT_MSG_GUILD_ACHIEVEMENT = "[GA]",
	CHAT_MSG_OFFICER = "[GO]",
	CHAT_MSG_CHANNEL = "[C]",
	CHAT_MSG_PARTY = "[P]",
	CHAT_MSG_PARTY_LEADER = "[PL]",
	CHAT_MSG_RAID = "[R]",
	CHAT_MSG_RAID_LEADER = "[RL]",
	CHAT_MSG_BATTLEGROUND = "[B]",
	CHAT_MSG_BATTLEGROUND_LEADER = "[BL]",
	CHAT_MSG_WHISPER = "[W]",
	CHAT_MSG_WHISPER_INFORM = "[T]",
	CHAT_MSG_SYSTEM = "[SYSTEM]"
}

local CHAT_EMOJIS = {
	{ tex = "Interface\\emoji\\WM_EMOJI_5HEAD.blp", code = ":5head:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_ALLIANCE.blp", code = ":alliance:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_ANGRY.blp", code = ":angry:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_BOGGED.blp", code = ":bogged:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_BRUH.blp", code = ":bruh:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_CLASS_DK.blp", code = ":dk:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_CLASS_DRUID.blp", code = ":druid:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_CLASS_HUNTER.blp", code = ":hunter:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_CLASS_MAGE.blp", code = ":mage:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_CLASS_PALADIN.blp", code = ":paladin:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_CLASS_PRIEST.blp", code = ":priest:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_CLASS_ROGUE.blp", code = ":rogue:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_CLASS_SHAMAN.blp", code = ":shaman:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_CLASS_WARLOCK.blp", code = ":warlock:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_CLASS_WARRIOR.blp", code = ":warrior:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_CLOWN.blp", code = ":clown:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_CRASH.blp", code = ":crash:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_DEADGE.blp", code = ":deadge:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_DENTGE.blp", code = ":dentge:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_DESPAIR.blp", code = ":despair:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_DOGE.blp", code = ":doge:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_DORF.blp", code = ":dorf:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_DRAMA.blp", code = ":drama:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_EZMANE.blp", code = ":ezmane:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_FACEPALM.blp", code = ":facepalm:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_FEELSSTRONG.blp", code = ":feelsstrong:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_HEART.blp", code = ":heart:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_HMM.blp", code = ":hmm:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_HORDE.blp", code = ":horde:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_HUH.blp", code = ":huh:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_HYPE.blp", code = ":hype:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_JUICE.blp", code = ":juice:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_KEK.blp", code = ":kek:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_KEKWAIT.blp", code = ":kekwait:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_KEKW.blp", code = ":kekw:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_KISS.blp", code = ":kiss:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_LAY.blp", code = ":lay:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_LOOKDOWN.blp", code = ":lookdown:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_LOOKUP.blp", code = ":lookup:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_MADGE.blp", code = ":madge:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_MONKAGIGA.blp", code = ":monkagiga:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_MONKALAUGH.blp", code = ":monkalaugh:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_MONKASTOP.blp", code = ":monkastop:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_NO.blp", code = ":no:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_OKAYGE.blp", code = ":okayge:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_OK.blp", code = ":ok:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_ORCGE.blp", code = ":orcge:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_PAUSECHAMP.blp", code = ":pausechamp:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_PEEPOCOMFY.blp", code = ":peepocomfy:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_PEEPOHAPPY.blp", code = ":peepohappy:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_PEEPOSAD.blp", code = ":peeposad:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_PEEPOSCARLET.blp", code = ":peeposcarlet:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_PEON.blp", code = ":peon:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_PEPEEZ.blp", code = ":pepez:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_PEPEGA.blp", code = ":pepega:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_PEPEHANDS.blp", code = ":pepehands:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_PEPELAUGH.blp", code = ":pepelaugh:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_PEPEW.blp", code = ":pepew:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_POGGIES.blp", code = ":poggies:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_QUEST.blp", code = ":quest:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_QUESTION.blp", code = ":question:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_RICH.blp", code = ":rich:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_SADGE.blp", code = ":sadge:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_SALLYGIGA.blp", code = ":sallygiga:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_SALLYHYPER.blp", code = ":hyper:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_SALLYS.blp", code = ":sallys:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_SALLYSTARE.blp", code = ":sallystare:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_SALLYWOW.blp", code = ":sallywow:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_SMUG.blp", code = ":smug:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_STARE.blp", code = ":stare:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_SUSGE.blp", code = ":susge:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_THINK.blp", code = ":think:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_UMM.blp", code = ":umm:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_WAVE.blp", code = ":wave:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_YEA.blp", code = ":yea:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_YES.blp", code = ":yes:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_YESHONEY.blp", code = ":yeshoney:" },
	{ tex = "Interface\\emoji\\WM_EMOJI_YIKERS.blp", code = ":yikers:" }
}

f:EnableMouse(true)

f:SetBackdrop( { bgFile = bgFile, edgeFile = edgeFile, edgeSize = 1, insets = { left = 0, right = 0, top = 0, bottom = 0 } } )
f:SetBackdropColor(0.2, 0.2, 0.2, 1)
f:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b, 1)

f:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 1, 20)
f:SetSize(432, 200)

local function ColorName(name, guid)
	if not name then return "?" end

	local _, class = GetPlayerInfoByGUID(guid)

	if class and RAID_CLASS_COLORS[class] then
		local c = RAID_CLASS_COLORS[class]

		return string.format("|cff%02x%02x%02x%s|r", c.r * 255, c.g * 255, c.b * 255, name)
	end

	return name
end

local function SpellIcon(spellID)
	if not spellID then return "" end

	local icon = select(3, GetSpellInfo(spellID))

	return icon and ("|T"..icon..":14:14:0:0|t") or ""
end

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

local function LogEvent(self, srcGUID, srcName, spellID, spellName, amount, dstGUID, dstName, kind)
	local msg

	if amount then
		msg = string.format("%s %s%s %s %s", ColorName(srcName, srcGUID), SpellIcon(spellID), spellName or "", ColorAmount(amount, kind), ColorName(dstName, dstGUID))
	else
		msg = string.format("%s %s%s %s", ColorName(srcName, srcGUID), SpellIcon(spellID), spellName or "", ColorName(dstName, dstGUID))
	end

	self:AddMessage(msg)
end

local function OnCombatEvent(self, ...)
	local timestamp, subevent, srcGUID, srcName, _, dstGUID, dstName, _, spellID, spellName = ...
	local amount

	if subevent == "SWING_DAMAGE" then
		amount = select(9, ...)

		LogEvent(self, srcGUID, srcName, nil, "Melee", amount, dstGUID, dstName, "DAMAGE")
	elseif subevent == "RANGE_DAMAGE" then
		amount = select(12, ...)

		LogEvent(self, srcGUID, srcName, spellID, spellName, amount, dstGUID, dstName, "DAMAGE")
	elseif subevent == "SPELL_DAMAGE" then
		amount = select(12, ...)

		LogEvent(self, srcGUID, srcName, spellID, spellName, amount, dstGUID, dstName, "DAMAGE")
	elseif subevent == "SPELL_PERIODIC_DAMAGE" then
		amount = select(12, ...)

		LogEvent(self, srcGUID, srcName, spellID, spellName.." (DoT)", amount, dstGUID, dstName, "DAMAGE")
	elseif subevent == "DAMAGE_SHIELD" then
		amount = select(12, ...)

		LogEvent(self, srcGUID, srcName, spellID, spellName.." (Shield)", amount, dstGUID, dstName, "DAMAGE")
	elseif subevent == "DAMAGE_SPLIT" then
		amount = select(12, ...)

		LogEvent(self, srcGUID, srcName, spellID, spellName.." (Split)", amount, dstGUID, dstName, "DAMAGE")
	elseif subevent == "SPELL_HEAL" then
		amount = select(12, ...)

		LogEvent(self, srcGUID, srcName, spellID, spellName, amount, dstGUID, dstName, "HEAL")
	elseif subevent == "SPELL_PERIODIC_HEAL" then
		amount = select(12, ...)

		LogEvent(self, srcGUID, srcName, spellID, spellName.." (HoT)", amount, dstGUID, dstName, "HEAL")
	elseif subevent == "SPELL_ABSORBED" then
		local n = select("#", ...)
		local absorbed = select(n, ...)

		LogEvent(self, srcGUID, srcName, spellID, spellName, absorbed, dstGUID, dstName, "ABSORB")
	elseif subevent == "SPELL_AURA_APPLIED" then
		LogEvent(self, srcGUID, srcName, spellID, spellName, nil, dstGUID, dstName, "BUFF")
	elseif subevent == "SPELL_AURA_REFRESH" then
		LogEvent(self, srcGUID, srcName, spellID, spellName.." (ref)", nil, dstGUID, dstName, "BUFF")
	elseif subevent == "SPELL_AURA_REMOVED" then
		LogEvent(self, srcGUID, srcName, spellID, spellName.." (fade)", nil, dstGUID, dstName, "BUFF")
	elseif subevent == "SWING_MISSED" then
		local missType = select(9, ...)

		LogEvent(self, srcGUID, srcName, nil, missType, 0, dstGUID, dstName, "BUFF")
	elseif subevent == "RANGE_MISSED" then
		local missType = select(12, ...)

		LogEvent(self, srcGUID, srcName, spellID, spellName.." ("..missType..")", 0, dstGUID, dstName, "BUFF")
	elseif subevent == "SPELL_MISSED" then
		local missType = select(12, ...)

		LogEvent(self, srcGUID, srcName, spellID, spellName.." ("..missType..")", 0, dstGUID, dstName, "BUFF")
	elseif subevent == "SPELL_PERIODIC_MISSED" then
		local missType = select(12, ...)

		LogEvent(self, srcGUID, srcName, spellID, spellName.." ("..missType..")", 0, dstGUID, dstName, "BUFF")
	elseif subevent == "ENVIRONMENTAL_DAMAGE" then
		local envType = spellID
		amount = select(10, ...)

		LogEvent(self, srcGUID, srcName, nil, envType, amount, dstGUID, dstName, "DAMAGE")
	end
end

local function ReplaceRaidIcons(msg)
	if not msg then return "" end

	local icons = { star = 1, circle = 2, diamond = 3, triangle = 4, moon = 5, square = 6, cross = 7, x = 7, skull = 8 }

	return msg:gsub("{(.-)}", function(token)
		local index = icons[token:lower()]

		if index then
			return "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..index..":18:18|t"
		elseif token:lower():match("^rt%d$") then
			return "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..token:lower():match("^rt(%d)$")..":0|t"
		end

		return "{"..token.."}"
	end)
end

local function ReplaceEmojis(msg)
	if not msg then return "" end

	return msg:gsub(":(.-):", function(token)
		local icon = nil

		for _, data in ipairs(CHAT_EMOJIS) do
			if data.code == ":"..token..":" then
				icon = data.tex
				break
			end
		end

		if icon then return "|T"..icon..":24:24|t" end

		return ":"..token..":"
	end)
end

local function OnEnter(self)
	f.FrameStrata = f:GetFrameStrata()
	f:SetFrameStrata("HIGH")
	f.action = "grow"
end

local function OnLeave(self)
	f:SetFrameStrata(f.FrameStrata)
	f.action = "shrink"
end

local function OnHyperlinkClick(self, link, text, button)
	SetItemRef(link, text, button)
end

local function OnHyperlinkEnter(self, link)
	f.action = "grow"
	f:SetFrameStrata("HIGH")

	local type = link:match("^(.-):")

	if type == "item" or type == "enchant" or type == "spell" or type == "quest" then
		ShowUIPanel(GameTooltip)
		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end
end

local function OnHyperlinkLeave(self, link)
	if link ~= nil then
		local type = link:match("^(.-):")

		if type == "item" or type == "enchant" or type == "spell" or type == "quest" then
			HideUIPanel(GameTooltip)
		end
	end
end

local function OnUpdate(self, elapsed)
	self.timer = (self.timer or 0) + elapsed
	if self.timer < 0.01 then return end
	self.timer = 0

	if self.action == "shrink" and self:GetHeight() > collapsedHeight then
		self:SetHeight(math.max(self:GetHeight() - 50, collapsedHeight))
	elseif self.action == "grow" and self:GetHeight() < expandedHeight then
		self:SetHeight(math.min(self:GetHeight() + 50, expandedHeight))
	end
end

function f:PLAYER_LOGIN(self, ...)
	local eb = ChatFrame1EditBox

	if eb then
		eb:SetParent(UIParent)
		eb:SetFrameStrata("HIGH")
		eb:SetFrameLevel(SteakChatFrame:GetFrameLevel()+2)
		eb:SetPoint("TOPLEFT", f, "TOPLEFT", 6, -6)
		eb:SetPoint("TOPRIGHT", f, "TOPRIGHT", -6, -6)
		eb:SetFont("Interface\\AddOns\\SteakChat\\Fonts\\Audiowide-Regular.ttf", 9, "OUTLINE")
		_G[eb:GetName().."Header"]:SetFont("Interface\\AddOns\\SteakChat\\Fonts\\Audiowide-Regular.ttf", 9, "OUTLINE")

		ChatFrame1EditBoxLeft:SetTexture(0, 0, 0, 0.8)
		ChatFrame1EditBoxMid:SetTexture(0, 0, 0, 0.8)
		ChatFrame1EditBoxRight:SetTexture(0, 0, 0, 0.8)

		ChatFrame1EditBoxLeft:SetPoint("LEFT", ChatFrame1EditBox, "LEFT", 10, 0)
		ChatFrame1EditBoxLeft:SetHeight(ChatFrame1EditBox:GetHeight()-16)

		ChatFrame1EditBoxMid:SetHeight(ChatFrame1EditBoxLeft:GetHeight())

		ChatFrame1EditBoxRight:SetPoint("RIGHT", ChatFrame1EditBox, "RIGHT", -10, 0)
		ChatFrame1EditBoxRight:SetHeight(ChatFrame1EditBoxLeft:GetHeight())
	end

	--ChatFrame1EditBoxLeft:Hide()
	--ChatFrame1EditBoxMid:Hide()
	--ChatFrame1EditBoxRight:Hide()
	--ChatFrame1EditBoxLeft:SetTexture(nil)
	--ChatFrame1EditBoxMid:SetTexture(nil)
	--ChatFrame1EditBoxRight:SetTexture(nil)

	local frames = {
		ChatFrameMenuButton,
		FriendsMicroButton
	}

	for i=1,7 do
		table.insert(frames, _G["ChatFrame"..i])
		table.insert(frames, _G["ChatFrame"..i.."Tab"])
	end

	for _, frame in ipairs(frames) do
		if frame then
			frame:UnregisterAllEvents()
			frame:SetScript("OnEvent", nil)
			frame:SetScript("OnUpdate", nil)
			frame:SetScript("OnShow", function(self) self:Hide() end)
			frame:Hide()
		end
	end

	DEFAULT_CHAT_FRAME = f.windows[1]

	HelpMicroButton:SetParent(f)
	HelpMicroButton:ClearAllPoints()
	HelpMicroButton:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
	HelpMicroButton.scale = 28/HelpMicroButton:GetHeight()
	HelpMicroButton:SetScale(HelpMicroButton.scale)
end

function f:PLAYER_ENTERING_WORLD(self, ...)
	HelpMicroButton:SetParent(f)
	HelpMicroButton:ClearAllPoints()
	HelpMicroButton:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
	HelpMicroButton:SetScale(HelpMicroButton.scale)
	HelpMicroButton:Show()
end

local function OnEvent(self, event, ...)
	if event:match("^CHAT_MSG_WHISPER") then
		local author = select(2, ...)

		auto = author:match("([^%-]+)")
		lastWhisper = author

		if ChatEdit_SetLastTellTarget then
			--ChatEdit_SetLastTellTarget(self.editBox, author)
			ChatEdit_SetLastTellTarget(author)
		end
	end

	if self[event] then
		self[event](self, event, ...)
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		OnCombatEvent(self, ...)
		--[[
		local timestamp, subEvent, srcGUID, srcName, srcFlags, destGUID, destName, destFlags = ...

		--if bit.band(srcFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 then
		if srcGUID and tonumber(srcGUID:sub(1, 5), 16) == 0 then
			local _, class, _, race, faction, name = GetPlayerInfoByGUID(srcGUID)
			local srcPlayerLink = ("|cff%02x%02x%02x|Hplayer:%s|h[%s]|h|r"):format(RAID_CLASS_COLORS[class].r*255, RAID_CLASS_COLORS[class].g*255, RAID_CLASS_COLORS[class].b*255, name, name)
		end

		--if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 then
		if destGUID and tonumber(destGUID:sub(1, 5), 16) == 0 then
			local _, class, _, race, faction, name = GetPlayerInfoByGUID(destGUID)
			local destPlayerLink = ("|cff%02x%02x%02x|Hplayer:%s|h[%s]|h|r"):format(RAID_CLASS_COLORS[class].r*255, RAID_CLASS_COLORS[class].g*255, RAID_CLASS_COLORS[class].b*255, name, name)
		end
		]]
	elseif event == "CHAT_MSG_SYSTEM" then
		local msg, _, channel, sender, _, _, chanID, chanName, _, _, guid = ...
		local timestamp = date("|cffff8000[%H:%M:%S]|r")
		local r, g, b = unpack(CHAT_COLORS[event])
		local chan = channel or CHAT_CHANNEL[event]

		self:AddMessage(("%s%s %s"):format(timestamp, chan, msg), r, g, b)	
	elseif event == "CHAT_MSG_EMOTE" or event == "CHAT_MSG_TEXT_EMOTE" then
		local msg, sender, _, _, _, _, _, _, _, _, _, guid = ...
		local timestamp = date("|cffff8000[%H:%M:%S]|r")
		local _, class, _, race, faction, name = GetPlayerInfoByGUID(guid)		
		local r, g, b = unpack(CHAT_COLORS[event])
		local classColor = RAID_CLASS_COLORS[class] or { r = 0.5, g = 0.5, b = 0.5 }
		local player = ("|cff%02x%02x%02x|Hplayer:%s|h[%s]|h|r"):format(classColor.r*255, classColor.g*255, classColor.b*255, name or sender, name or sender)

		msg = msg:gsub(sender, player)

		self:AddMessage(("%s %s"):format(timestamp, msg), r, g, b)
	elseif event == "CHAT_MSG_GUILD_ACHIEVEMENT" then
		local msg, sender, _, channel, _, _, _, chanID, chanName, _, _, guid = ...
		local timestamp = date("|cffff8000[%H:%M:%S]|r")
		local class, race, faction, name, player, classColor
	
		if guid and guid ~= "" then
			_, class, _, race, faction, name = GetPlayerInfoByGUID(guid)
			classColor = RAID_CLASS_COLORS[class] or { r = 0.5, g = 0.5, b = 0.5 }
			player = ("|cff%02x%02x%02x|Hplayer:%s|h[%s]|h|r"):format(classColor.r*255, classColor.g*255, classColor.b*255, name or sender, name or sender)
		end

		local r, g, b = unpack(CHAT_COLORS[event] or { 0.5, 0.5, 0.5 })
		local chan = channel or chanID or CHAT_CHANNEL[event]
		local i = 1
		local guildie = false
		local gName, gRank, gLevel, gNote
		local score = 0

		for _, keyword in ipairs(CHAT_FILTER) do
			if msg:lower():find(keyword) then
				score = score + 1
			end
		end

		if score >= 3 then return end

		while GetGuildRosterInfo(i) ~= nil do
			gName, gRank, _, gLevel, _, _, gNote = GetGuildRosterInfo(i)
			
			if gName == (name or sender) then
				guildie = true
				break
			end
			
			i = i + 1
		end

		local factionIcon = ("|TInterface\\PVPFrame\\PVP-Currency-%s:18:18|t"):format(faction == 2 and "Horde" or "Alliance")
		if msg:match("^{%?") then
			--factionIcon = ("%s%s"):format("|TInterface\\CharacterFrame\\UI-Player-PlayTimeTired:18:18|t", factionIcon)
			--factionIcon = ("%s%s"):format("|TInterface\\AddOns\\SteakChat\\hardcore.tga:18:18|t", factionIcon)
			factionIcon = ("%s%s"):format("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:14:14|t", factionIcon)
			msg = msg:gsub("^{%?", "")
		end

		if msg:match("^%%s ") then
			msg = msg:gsub("^%%s ", "")
		end

		msg = ReplaceRaidIcons(msg)
		msg = ReplaceEmojis(msg)

		chan = chan and chan ~= "" and "["..chan.."]" or ""

		if guildie then
			if gNote and gNote ~= "" then
				self:AddMessage(("%s%s%s[%s]%s[%s]:(%s) %s"):format(timestamp, chan, factionIcon, gLevel, player, gRank, gNote, msg), r, g, b)
			else
				self:AddMessage(("%s%s%s[%s]%s[%s]: %s"):format(timestamp, chan, factionIcon, gLevel, player, gRank, msg), r, g, b)
			end
		else
			self:AddMessage(("%s%s%s%s: %s"):format(timestamp, chan, factionIcon, player, msg), r, g, b)
		end
	elseif event == "CHAT_MSG_LOOT" or event == "CHAT_MSG_SKILL" then
		local msg = ...
		local timestamp = date("|cffff8000[%H:%M:%S]|r")
		local name = msg:match("^(.-) receive")
		local r, g, b = unpack(CHAT_COLORS[event])
		name = not name and msg:match("^(.-) create") or name

		if name == "You" then
			local _, class = UnitClass("player")
			name = UnitName("player")
			msg = msg:gsub("^You", ("|cff%02x%02x%02x|Hplayer:%s|h[%s]|h|r"):format(RAID_CLASS_COLORS[class].r*255, RAID_CLASS_COLORS[class].g*255, RAID_CLASS_COLORS[class].b*255, name, "You"))
		else
			local groupType = GetNumRaidMembers() > 0 and "raid" or "party"
			local numGroupMembers = groupType == "raid" and GetNumRaidMembers() or GetNumPartyMembers()

			for i=1,numGroupMembers do
				local unit = groupType..i
				local _, class = UnitClass(unit)

				if UnitName(unit) == name then
					msg = msg:gsub("^"..name, ("|cff%02x%02x%02x|Hplayer:%s|h[%s]|h|r"):format(RAID_CLASS_COLORS[class].r*255, RAID_CLASS_COLORS[class].g*255, RAID_CLASS_COLORS[class].b*255, name, name))
					break
				end
			end
		end

		self:AddMessage(("%s %s"):format(timestamp, msg), r, g, b)
	elseif event:match("^CHAT_MSG_MONSTER_") or event:match("^CHAT_MSG_RAID_BOSS_") then
		local msg, sender, _, channel, _, _, _, chanID, chanName = ...
		local timestamp = date("|cffff8000[%H:%M:%S]|r")
		local class, race, faction, name, player, classColor
	
		local r, g, b = unpack(CHAT_COLORS[event] or { 0.5, 0.5, 0.5 })
		local chan = channel or chanID or CHAT_CHANNEL[event]

		local factionIcon = ("|TInterface\\PVPFrame\\PVP-Currency-%s:18:18|t"):format(faction == 2 and "Horde" or "Alliance")
		if msg:match("^{%?") then
			--factionIcon = ("%s%s"):format("|TInterface\\CharacterFrame\\UI-Player-PlayTimeTired:18:18|t", factionIcon)
			--factionIcon = ("%s%s"):format("|TInterface\\AddOns\\SteakChat\\hardcore.tga:18:18|t", factionIcon)
			factionIcon = ("%s%s"):format("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:14:14|t", factionIcon)
			msg = msg:gsub("^{%?", "")
		end

		msg = ReplaceRaidIcons(msg)
		msg = ReplaceEmojis(msg)

		chan = chan and chan ~= "" and "["..chan.."]" or ""

		self:AddMessage(("%s%s%s%s: %s"):format(timestamp, chan, factionIcon, sender, msg), r, g, b)
	elseif event:match("^CHAT_MSG_") then
		local msg, sender, _, channel, _, _, _, chanID, chanName, _, _, guid = ...
		local timestamp = date("|cffff8000[%H:%M:%S]|r")
		local class, race, faction, name, player, classColor
	
		if guid and guid ~= "" then
			_, class, _, race, faction, name = GetPlayerInfoByGUID(guid)
			classColor = RAID_CLASS_COLORS[class] or { r = 0.5, g = 0.5, b = 0.5 }
			player = ("|cff%02x%02x%02x|Hplayer:%s|h[%s]|h|r"):format(classColor.r*255, classColor.g*255, classColor.b*255, name or sender, name or sender)
		end

		local r, g, b = unpack(CHAT_COLORS[event] or { 0.5, 0.5, 0.5 })
		local chan = channel or chanID or CHAT_CHANNEL[event]
		local i = 1
		local guildie = false
		local gName, gRank, gLevel, gNote
		local score = 0

		for _, keyword in ipairs(CHAT_FILTER) do
			if msg:lower():find(keyword) then
				score = score + 1
			end
		end

		if score >= 3 then return end

		while GetGuildRosterInfo(i) ~= nil do
			gName, gRank, _, gLevel, _, _, gNote = GetGuildRosterInfo(i)
			
			if gName == (name or sender) then
				guildie = true
				break
			end
			
			i = i + 1
		end

		local factionIcon = ("|TInterface\\PVPFrame\\PVP-Currency-%s:18:18|t"):format(faction == 2 and "Horde" or "Alliance")
		if msg:match("^{%?") then
			--factionIcon = ("%s%s"):format("|TInterface\\CharacterFrame\\UI-Player-PlayTimeTired:18:18|t", factionIcon)
			--factionIcon = ("%s%s"):format("|TInterface\\AddOns\\SteakChat\\hardcore.tga:18:18|t", factionIcon)
			factionIcon = ("%s%s"):format("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:14:14|t", factionIcon)
			msg = msg:gsub("^{%?", "")
		end

		msg = ReplaceRaidIcons(msg)
		msg = ReplaceEmojis(msg)

		chan = chan and chan ~= "" and "["..chan.."]" or ""

		if guildie then
			if gNote and gNote ~= "" then
				self:AddMessage(("%s%s%s[%s]%s[%s]:(%s) %s"):format(timestamp, chan, factionIcon, gLevel, player, gRank, gNote, msg), r, g, b)
			else
				self:AddMessage(("%s%s%s[%s]%s[%s]: %s"):format(timestamp, chan, factionIcon, gLevel, player, gRank, msg), r, g, b)
			end
		else
			self:AddMessage(("%s%s%s%s: %s"):format(timestamp, chan, factionIcon, player, msg), r, g, b)
		end
	end
end

f:SetScript("OnEnter", OnEnter)
f:SetScript("OnLeave", OnLeave)
f:SetScript("OnUpdate", OnUpdate)
f:SetScript("OnEvent", OnEvent)

f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_ENTERING_WORLD")

f.windows = {}
f.tabs = {}

local function CreateChatWindow(title, events)
	local cf = CreateFrame("ScrollingMessageFrame", nil, f)

	cf:SetFont("Interface\\AddOns\\SteakChat\\Fonts\\Audiowide-Regular.ttf", 9, "OUTLINE")
	cf:SetJustifyH("LEFT")
	cf:SetFading(false)
	cf:SetTimeVisible(0)
	cf:SetFadeDuration(0)
	cf:SetIndentedWordWrap(true)
	cf:SetHyperlinksEnabled(true)
	cf:SetMaxLines(500)
	cf:EnableMouseWheel(true)
	cf:EnableMouse(true)

	cf.editBox = ChatFrame1EditBox

	cf.print = function(self, ...)
		local params = {...}

		for i, param in ipairs(params) do
			if not param then
				params[i] = "nil"
			end
		end

		self:AddMessage(table.concat(params, ", "))
	end

	cf:SetPoint("TOPLEFT", f, "TOPLEFT", 6, -6)
	cf:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -6, 20)

	cf:SetScript("OnHyperlinkClick", OnHyperlinkClick)
	cf:SetScript("OnHyperlinkEnter", OnHyperlinkEnter)
	cf:SetScript("OnHyperlinkLeave", OnHyperlinkLeave)
	cf:SetScript("OnEnter", OnEnter)
	cf:SetScript("OnLeave", OnLeave)

	cf:SetScript("OnMouseWheel", function(self, delta)
		if delta > 0 then
			self:ScrollUp()
		else
			self:ScrollDown()
		end
	end)

	cf:SetScript("OnEvent", OnEvent)

	for _, event in ipairs(events) do
		cf:RegisterEvent(event)
	end

	table.insert(f.windows, cf)

	local tab = CreateFrame("Button", nil, f)

	tab:SetBackdrop( { bgFile = bgFile, edgeFile = edgeFile, edgeSize = 1, insets = { left = 0, right = 0, top = 0, bottom = 0 } } )
	tab:SetBackdropColor(0.2, 0.2, 0.2, 1)
	tab:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b, 1)

	local label = tab:CreateFontString(nil, "OVERLAY")
	label:SetPoint("CENTER")
	label:SetFont("Interface\\AddOns\\SteakChat\\Fonts\\Audiowide-Regular.ttf", 8, "OUTLINE")
	label:SetText(title)
	label:SetTextColor(1, 1, 1)
	tab:SetSize(label:GetStringWidth() + 20, 12)
	tab.index = #f.windows

	tab:SetScript("OnClick", function(self, button)
		for i, cf in ipairs(f.windows) do
			if i == self.index then
				f.tabs[i]:SetBackdropColor(0.5, 0.5, 0.5, 1)
				cf:Show()
			else
				f.tabs[i]:SetBackdropColor(0.2, 0.2, 0.2, 1)
				cf:Hide()
			end
		end
	end)

	table.insert(f.tabs, tab)
end

CreateChatWindow("General", {
	"CHAT_MSG_SAY",
	"CHAT_MSG_YELL",
	"CHAT_MSG_CHANNEL",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_PARTY_LEADER",
	"CHAT_MSG_RAID",
	"CHAT_MSG_RAID_LEADER",
	"CHAT_MSG_RAID_WARNING",
	"CHAT_MSG_INSTANCE_CHAT",
	"CHAT_MSG_INSTANCE_CHAT_LEADER",
	"CHAT_MSG_BATTLEGROUND",
	"CHAT_MSG_BATTLEGROUND_LEADER",
	"CHAT_MSG_GUILD",
	"CHAT_MSG_GUILD_ACHIEVEMENT",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_GUILD_ITEM_LOOTED",
	"CHAT_MSG_SYSTEM",
	"CHAT_MSG_EMOTE",
	"CHAT_MSG_MONSTER_SAY",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_MONSTER_EMOTE",
	"CHAT_MSG_MONSTER_WHISPER",
	"CHAT_MSG_MONSTER_PARTY",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_RAID_BOSS_WHISPER",
	"CHAT_MSG_TEXT_EMOTE",
	"CHAT_MSG_CHANNEL_JOIN",
	"CHAT_MSG_CHANNEL_LEAVE",
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_WHISPER_INFORM",
	"CHAT_MSG_SKILL",
	"CHAT_MSG_REPUTATION",
	"CHAT_MSG_LOOT"
})

CreateChatWindow("Guild", {
	"CHAT_MSG_GUILD",
	"CHAT_MSG_GUILD_ACHIEVEMENT",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_GUILD_ITEM_LOOTED"
})

CreateChatWindow("Group", {
	"CHAT_MSG_PARTY",
	"CHAT_MSG_PARTY_LEADER",
	"CHAT_MSG_RAID",
	"CHAT_MSG_RAID_LEADER",
	"CHAT_MSG_RAID_WARNING",
	"CHAT_MSG_INSTANCE_CHAT",
	"CHAT_MSG_INSTANCE_CHAT_LEADER",
	"CHAT_MSG_BATTLEGROUND",
	"CHAT_MSG_BATTLEGROUND_LEADER"
})

CreateChatWindow("Whisper", {
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_WHISPER_INFORM"
})

CreateChatWindow("Loot", {
	"CHAT_MSG_LOOT",
	"CHAT_MSG_GUILD_ITEM_LOOTED"
})

CreateChatWindow("Combat Log", {
	"COMBAT_LOG_EVENT_UNFILTERED"
})

for index, tab in ipairs(f.tabs) do
	if index == 1 then
		f.tabs[index]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 2, 2)
	else
		f.tabs[index]:SetPoint("LEFT", f.tabs[index-1], "RIGHT", 2, 0)
	end
end

for i=2,#f.windows do
	f.windows[i]:Hide()
end

f.tabs[1]:SetBackdropColor(0.5, 0.5, 0.5, 1)

local ToastEvents = {
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_GUILD",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_RAID",
	"CHAT_MSG_RAID_LEADER",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_PARTY_LEADER",
	"CHAT_MSG_INSTANCE_CHAT",
	"CHAT_MSG_INSTANCE_CHAT_LEADER",
	"CHAT_MSG_BATTLEGROUND",
	"CHAT_MSG_BATTLEGROUND_LEADER",
}

local tf = CreateFrame("ScrollingMessageFrame", "ToastChatFrame", UIParent)
tf:SetPoint("CENTER", UIParent, "CENTER", 0, 250)
tf:EnableMouse(false)
tf:SetWidth(500)
tf:SetHeight(300)

tf:EnableKeyboard(false)
tf:EnableMouseWheel(false)
tf:SetFading(true)
tf:SetTimeVisible(10)
tf:SetFadeDuration(3)

tf:SetFont("Interface\\AddOns\\SteakChat\\Fonts\\Audiowide-Regular.ttf", 10, "OUTLINE")
tf:SetTextColor(1, 1, 1, 1)
tf:SetJustifyH("LEFT")
tf:SetMaxLines(64)

for _,event in ipairs(ToastEvents) do
	tf:RegisterEvent(event)
end

tf:SetScript("OnEvent", OnEvent)
