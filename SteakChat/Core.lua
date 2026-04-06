local f = CreateFrame("Frame", "SteakChatFrame", UIParent)

local _, class = UnitClass("player")
local borderColor = RAID_CLASS_COLORS[class]

local bgFile = "Interface\\ChatFrame\\ChatFrameBackground"
local edgeFile = "Interface\\Buttons\\WHITE8x8"

local expandedHeight = GetScreenHeight() * 0.75
local collapsedHeight = 217

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
	CHAT_MSG_BATTLEGROUND_LEADER = { 1, 0.8, 0.7 }
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
		eb:SetParent(f)
		eb:SetPoint("TOPLEFT", f, "TOPLEFT", 6, -6)
		eb:SetPoint("TOPRIGHT", f, "TOPRIGHT", -6, -6)
		eb:SetFont("Interface\\AddOns\\SteakChat\\Fonts\\Audiowide-Regular.ttf", 9, "OUTLINE")
		_G[eb:GetName().."Header"]:SetFont("Interface\\AddOns\\SteakChat\\Fonts\\Audiowide-Regular.ttf", 9, "OUTLINE")
	end

	ChatFrame1EditBoxLeft:Hide()
	ChatFrame1EditBoxMid:Hide()
	ChatFrame1EditBoxRight:Hide()
	
	local bg = eb:CreateTexture(nil, "BACKGROUND")
	bg:SetTexture(0, 0, 0, 0.8)
	bg:SetPoint("TOPLEFT", eb, "TOPLEFT", 8, -8)
	bg:SetPoint("BOTTOMRIGHT", eb, "BOTTOMRIGHT", -8, 8)

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
	HelpMicroButton:SetScale(28/HelpMicroButton:GetHeight())
end

local function OnEvent(self, event, ...)
	if self[event] then
		self[event](self, event, ...)
	elseif event == "CHAT_MSG_SYSTEM" then
		local msg, _, channel, sender, _, _, chanID, chanName, _, _, guid = ...
		local timestamp = date("|cffff8000[%H:%M:%S]|r")
		local r, g, b = unpack(CHAT_COLORS[event])
		local message = "%s%s %s"
		local chan = channel or CHAT_CHANNEL[event]

		self:AddMessage(message:format(timestamp, chan, msg), r, g, b)	
	elseif event == "CHAT_MSG_EMOTE" or event == "CHAT_MSG_TEXT_EMOTE" then
		local msg, sender, _, _, _, _, _, _, _, _, _, guid = ...
		local timestamp = date("|cffff8000[%H:%M:%S]|r")
		local _, class, _, race, faction, name = GetPlayerInfoByGUID(guid)		
		local r, g, b = unpack(CHAT_COLORS[event])
		local classColor = RAID_CLASS_COLORS[class] or { r = 0.5, g = 0.5, b = 0.5 }
		local player = ("|cff%02x%02x%02x|Hplayer:%s|h[%s]|h|r"):format(classColor.r*255, classColor.g*255, classColor.b*255, name or "Unknown", name or "Unknown")

		msg = msg:gsub(sender, player)

		self:AddMessage(("%s %s"):format(timestamp, msg), r, g, b)
	elseif event == "CHAT_MSG_LOOT" then
		print(...)
	elseif event:match("^CHAT_MSG_") then
		local msg, sender, _, channel, _, _, _, chanID, chanName, _, _, guid = ...
		local timestamp = date("|cffff8000[%H:%M:%S]|r")
		local _, class, _, race, faction, name = GetPlayerInfoByGUID(guid)
		local r, g, b = unpack(CHAT_COLORS[event])
		local classColor = RAID_CLASS_COLORS[class] or { r = 0.5, g = 0.5, b = 0.5 }
		local player = ("|cff%02x%02x%02x|Hplayer:%s|h[%s]|h|r"):format(classColor.r*255, classColor.g*255, classColor.b*255, name or "Unknown", name or "Unknown")
		local chan = channel or chanID or CHAT_CHANNEL[event]
		local i = 1
		local guildie = false
		local gName, gRank, gLevel, gNote

		while GetGuildRosterInfo(i) ~= nil do
			gName, gRank, _, gLevel, _, _, gNote = GetGuildRosterInfo(i)
			
			if gName == (name or sender) then
				guildie = true
				break
			end
			
			i = i + 1
		end

		local factionIcon = ("|TInterface\\PVPFrame\\PVP-Currency-%s:18:18|t"):format(faction == 2 and "Horde" or "Alliance")
		if msg:match("^{003/") then
			factionIcon = ("%s%s"):format("|TInterface\\CharacterFrame\\UI-Player-PlayTimeTired:18:18|t", factionIcon)
			msg = msg:gsub("^{%?", "")
		end

		msg = ReplaceRaidIcons(msg)
		msg = ReplaceEmojis(msg)

		chan = "["..chan.."]"

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
	"CHAT_MSG_TEXT_EMOTE",
	"CHAT_MSG_CHANNEL_JOIN",
	"CHAT_MSG_CHANNEL_LEAVE"
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
