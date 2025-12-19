local f = CreateFrame("Frame", "SteakChatFrame", UIParent)

f.FontSize = 16

f.expandedHeight = 600
f.collapsedHeight = 150

SteakChatPlayerData = {}

f.chatColors = {
	["CHAT_MSG_MONSTER_SAY"] = {
		["r"] = 0.5,
		["g"] = 0.5,
		["b"] = 0.5,
		["a"] = 1,
	},
	["CHAT_MSG_MONSTER_WHISPER"] = {
		["r"] = 1,
		["g"] = 0.8,
		["b"] = 0,
		["a"] = 1,
	},
	["CHAT_MSG_AFK"] = {
		["r"] = 1,
		["g"] = 1,
		["b"] = 0,
		["a"] = 1,
	},
	["CHAT_MSG_DND"] = {
		["r"] = 1,
		["g"] = 1,
		["b"] = 0,
		["a"] = 1,
	},
	["CHAT_MSG_ADDON"] = {
		["r"] = 1,
		["g"] = 1,
		["b"] = 0,
		["a"] = 1,
	},
	["CHAT_MSG_CHANNEL"] = {
		["r"] = 0.992157,
		["g"] = 0.752941,
		["b"] = 0.752941,
		["a"] = 1,
	},
	["CHAT_MSG_CHANNEL_JOIN"] = {
		["r"] = 0.992157,
		["g"] = 0.752941,
		["b"] = 0.752941,
		["a"] = 1,
	},
	["CHAT_MSG_CHANNEL_LEAVE"] = {
		["r"] = 0.992157,
		["g"] = 0.752941,
		["b"] = 0.752941,
		["a"] = 1,
	},
	["CHAT_MSG_EMOTE"] = {
		["r"] = 1,
		["g"] = 0.5,
		["b"] = 0,
		["a"] = 1,
	},
	["CHAT_MSG_TEXT_EMOTE"] = {
		["r"] = 1,
		["g"] = 0.5,
		["b"] = 0,
		["a"] = 1,
	},
	["CHAT_MSG_GUILD"] = {
		["r"] = 0.235294,
		["g"] = 0.886275,
		["b"] = 0.247059,
		["a"] = 1,
	},
	["CHAT_MSG_GUILD_ACHIEVEMENT"] = {
		["r"] = 1,
		["g"] = 1,
		["b"] = 0,
		["a"] = 1,
	},
	["CHAT_MSG_OFFICER"] = {
		["r"] = 0.250980,
		["g"] = 0.737255,
		["b"] = 0.250980,
		["a"] = 1,
	},
	["CHAT_MSG_MONSTER_SAY"] = {
		["r"] = 1,
		["g"] = 0.6,
		["b"] = 0,
		["a"] = 1,
	},
	["CHAT_MSG_MONSTER_WHISPER"] = {
		["r"] = 1,
		["g"] = 0,
		["b"] = 0,
		["a"] = 1,
	},
	["CHAT_MSG_PARTY"] = {
		["r"] = 0.666667,
		["g"] = 0.670588,
		["b"] = 1,
		["a"] = 1,
	},
	["CHAT_MSG_PARTY_LEADER"] = {
		["r"] = 0.4,
		["g"] = 0.4,
		["b"] = 0.8,
		["a"] = 1,
	},
	["CHAT_MSG_RAID"] = {
		["r"] = 1,
		["g"] = 0.5,
		["b"] = 0.039216,
		["a"] = 1,
	},
	["CHAT_MSG_RAID_LEADER"] = {
		["r"] = 1,
		["g"] = 0.282353,
		["b"] = 0.035294,
		["a"] = 1,
	},
	["CHAT_MSG_SAY"] = {
		["r"] = 1,
		["g"] = 1,
		["b"] = 1,
		["a"] = 1,
	},
	["CHAT_MSG_WHISPER"] = {
		["r"] = 1,
		["g"] = 0.4,
		["b"] = 0.7,
		["a"] = 1,
	},
	["CHAT_MSG_WHISPER_INFORM"] = {
		["r"] = 0.8,
		["g"] = 0.2,
		["b"] = 0.5,
		["a"] = 1,
	},
	["CHAT_MSG_YELL"] = {
		["r"] = 1,
		["g"] = 0,
		["b"] = 0,
		["a"] = 1,
	},
	["CHAT_MSG_BATTLEGROUND"] = {
		["r"] = 1,
		["g"] = 0.5,
		["b"] = 0,
		["a"] = 1,
	},
	["CHAT_MSG_BATTLEGROUND_LEADER"] = {
		["r"] = 1,
		["g"] = 0.862745,
		["b"] = 0.717647,
		["a"] = 1,
	},
	["CHAT_MSG_SYSTEM"] = {
		["r"] = 1,
		["g"] = 1,
		["b"] = 0,
		["a"] = 1,
	},
}

local ChatEvents = {
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_WHISPER_INFORM",
	"CHAT_MSG_GUILD",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_GUILD_ITEM_LOOTED",
	"CHAT_MSG_GUILD_ACHIEVEMENT",
	"CHAT_MSG_RAID",
	"CHAT_MSG_RAID_LEADER",
	--"CHAT_MSG_RAID_WARNING",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_PARTY_LEADER",
	"CHAT_MSG_INSTANCE_CHAT",
	"CHAT_MSG_INSTANCE_CHAT_LEADER",
	"CHAT_MSG_BATTLEGROUND",
	"CHAT_MSG_BATTLEGROUND_LEADER",
	"CHAT_MSG_SYSTEM",
	"CHAT_MSG_SAY",
	"CHAT_MSG_YELL",
	"CHAT_MSG_CHANNEL",
	--"CHAT_MSG_CHANNEL_JOIN",
	--"CHAT_MSG_CHANNEL_LEAVE",
	--"CHAT_MSG_EMOTE",
	--"CHAT_MSG_TEXT_EMOTE",
	"CHAT_MSG_MONSTER_SAY",
	"CHAT_MSG_MONSTER_WHISPER",
	"CHAT_MSG_MONSTER_YELL",
}

local OriginalDefaultChatFrameAddMessage = DEFAULT_CHAT_FRAME.AddMessage

function DEFAULT_CHAT_FRAME:AddMessage(message, r, g, b, messageID, ...)
	local currentTime = date("%H:%M:%S")
	local modifiedMessage = string.format("[%s] %s", currentTime, message)
	return OriginalDefaultChatFrameAddMessage(self, modifiedMessage, r, g, b, messageID, ...)
end

function f.GetClassColor(class)
        class = strupper(class:gsub(" ", ""))

        if RAID_CLASS_COLORS[class] ~= nil then
                return RAID_CLASS_COLORS[class].r or 1, RAID_CLASS_COLORS[class].g or 1, RAID_CLASS_COLORS[class].b or 1, RAID_CLASS_COLORS[class].a or 1
        else
                return 1, 0, 1, 1
        end
end

function f.GetNumGroupMembers()
	local party, raid = GetNumPartyMembers(), GetNumRaidMembers()

	if raid > 0 then
		return raid, "raid"
	elseif party > 0 then
		return party, "party"
	else
		return 0, nil
	end
end

function f.AddPlayerData(name, rank, level, class, note)
	SteakChatPlayerData[name] = SteakChatPlayerData[name] or {}

	if name ~= nil then SteakChatPlayerData[name].name = name end
	if level ~= nil then SteakChatPlayerData[name].level = level end
	if class ~= nil then SteakChatPlayerData[name].class = strupper(class) end
	if rank ~= nil then SteakChatPlayerData[name].rank = rank end
	if note ~= nil then SteakChatPlayerData[name].note = note end
end

function f.GetGuildInfoByName(memberName)
	local i = 1

	while GetGuildRosterInfo(i) ~= nil do
		local name, rank, rankIndex, level, class, _, note, officerNote, online = GetGuildRosterInfo(i)

		if name == memberName then
			return name, rank, rankIndex, level, class, note, officerNote, online
		end

		i = i + 1
	end
	return false
end

function f.GetPublicNote(charName)
	if not IsInGuild() then return end

	local i = 1

	while GetGuildRosterInfo(i) ~= nil do
		local name, _, _, _, _, _, note = GetGuildRosterInfo(i)

		if name == charName or charName == name:sub(1, -4) and note ~= "" then
			return note
		end
	end

	return false
end

function f.GetPlayerLink(playerName, lineID)
	if strlen(playerName) == 0 then return end

	local link = ""
	local name, rank, _, level, class, note = f.GetGuildInfoByName(playerName)

	if name == playerName then
		f.AddPlayerData(playerName, rank, level, class, note or "")

		local r, g, b, a = f.GetClassColor(class)
		return ("|cff%02x%02x%02x|Hplayer:%s:%s|h%s|h|r"):format((r * 255), (g * 255), (b * 255), playerName, lineID, playerName)
	elseif f.GetNumGroupMembers() > 0 then
		for i=1,f.GetNumGroupMembers(),1 do
			if UnitExists("raid"..i) and UnitName("raid"..i) == playerName then
				class = select(2, UnitClass("raid"..i))
				level = UnitLevel("raid"..i)
				f.AddPlayerData(playerName, nil, level, class, nil)

				local r, g, b, a = f.GetClassColor(class)
				return ("|cff%02x%02x%02x|Hplayer:%s:%s|h%s|h|r"):format(( r * 255), ( g * 255), ( b * 255), playerName, lineID, playerName)
			elseif UnitExists("party"..i) and UnitName("party"..i) == playerName then
				class = select(2, UnitClass("party"..i))
				level = UnitLevel("party"..i)
				f.AddPlayerData(playerName, nil, level, class, nil)

				local r, g, b, a = f.GetClassColor(class)
				return ("|cff%02x%02x%02x|Hplayer:%s:%s|h%s|h|r"):format(( r * 255), ( g * 255), ( b * 255), playerName, lineID, playerName)
			end
		end
	elseif SteakChatPlayerData[playerName] ~= nil then
		class = SteakChatPlayerData[playerName].class
		level = SteakChatPlayerData[playerName].level

		local r, g, b, a = f.GetClassColor(class)
		return ("|cff%02x%02x%02x|Hplayer:%s:%s|h%s|h|r"):format(( r * 255), ( g * 255), ( b * 255), playerName, lineID, playerName)
	else
		return ("|Hplayer:%s:%s|h%s|h|r"):format(playerName, lineID, playerName)
	end
end

function f.AddGuildInfo(self, event, msg, sender, ...)
	local i = 1

	while GetGuildRosterInfo(i) ~= nil do
		local name, rank, _, level, _, _, note, _, online = GetGuildRosterInfo(i)

		if name == sender or send == name:sub(1, -4) then
			if note ~= "" then
				msg = ("[|cffffff00%s:%d|r](|cffffff00%s|r) %s"):format(rank, level, note, msg)
			else
				msg = ("[|cffffff00%s:%d|r] %s"):format(rank, level, msg)
			end
			break
		end

		i = i + 1
	end

	return false, msg, sender, ...
end

function f.GetChatFrame(name)
        for i=1,NUM_CHAT_WINDOWS,1 do
                if GetChatWindowInfo(i) == name then
                        local frame = _G["ChatFrame"..i]
                        break
                end
        end
        
        if not frame then frame = FCF_OpenNewWindow(name) end
        
        return frame
end

function f:PLAYER_ENTERING_WORLD(self, event, ...)
	ChatFrameMenuButton:SetScript("OnShow", function(self) self:Hide() end)
	ChatFrameMenuButton:Hide()
end

function f:PLAYER_LOGIN(self, event, ...)
        if GetChannelName("World") == 0 then JoinChannelByName("World") end
        if GetChannelName("Trade") == 0 then JoinChannelByName("Trade") end
        if GetChannelName("General") == 0 then JoinChannelByName("General") end
 
        local frame = ChatFrame1
        
        ChatFrame_RemoveChannel(frame, "World")
        ChatFrame_RemoveChannel(frame, "Trade")
        ChatFrame_RemoveChannel(frame, "General")

        ChatFrame_RemoveMessageGroup(frame, "LOOT")
        ChatFrame_RemoveMessageGroup(frame, "COMBAT_FACTION_CHANGE")
        ChatFrame_RemoveMessageGroup(frame, "CURRENCY")
        ChatFrame_RemoveMessageGroup(frame, "MONEY")
        ChatFrame_RemoveMessageGroup(frame, "BN_WHISPER")
        ChatFrame_RemoveMessageGroup(frame, "WHISPER")
        ChatFrame_RemoveMessageGroup(frame, "IGNORED")
        ChatFrame_RemoveMessageGroup(frame, "GUILD")
        ChatFrame_RemoveMessageGroup(frame, "OFFICER")
        ChatFrame_RemoveMessageGroup(frame, "GUILD_ACHIEVEMENT")
        
        frame = f.GetChatFrame("Guild")

        ChatFrame_RemoveAllMessageGroups(frame)
        ChatFrame_RemoveAllChannels(frame)
        
        ChatFrame_AddMessageGroup(frame, "GUILD")
        ChatFrame_AddMessageGroup(frame, "OFFICER")
        ChatFrame_AddMessageGroup(frame, "GUILD_ACHIEVEMENT")        
                
        frame = f.GetChatFrame("Whispers")
        
        ChatFrame_RemoveAllMessageGroups(frame)
        ChatFrame_RemoveAllChannels(frame)

        ChatFrame_AddMessageGroup(frame, "WHISPER")
        ChatFrame_AddMessageGroup(frame, "BN_WHISPER")
        ChatFrame_AddMessageGroup(frame, "IGNORED")
                
        frame = f.GetChatFrame("Loot")

        ChatFrame_RemoveAllMessageGroups(frame)
        ChatFrame_RemoveAllChannels(frame)

        ChatFrame_AddMessageGroup(frame, "LOOT")
        ChatFrame_AddMessageGroup(frame, "COMBAT_FACTION_CHANGE")
        ChatFrame_AddMessageGroup(frame, "CURRENCY")
        ChatFrame_AddMessageGroup(frame, "MONEY")
        
        frame = f.GetChatFrame("World")
        
        ChatFrame_RemoveAllMessageGroups(frame)
        ChatFrame_RemoveAllChannels(frame)

        ChatFrame_AddChannel(frame, "World")
        ChatFrame_AddChannel(frame, "Trade")
        ChatFrame_AddChannel(frame, "General")
        
	ChatFrameMenuButton:Hide()
end

function f.OnEnter(self)
	self.FrameStrata = self:GetFrameStrata()
	self:SetFrameStrata("HIGH")
	ChatFrame1.action = "grow"
end

function f.OnLeave(self)
	self:SetFrameStrata(self.FrameStrata)
	ChatFrame1.action = "shrink"
end

function f.OnHyperlinkEnter(self, link)
	ChatFrame1.action = "grow"
	self:SetFrameStrata("HIGH")

	local type = strmatch(link, "^(.-):")
	if(type == "item" or type == "enchant" or type == "spell" or type == "quest") then
		ShowUIPanel(GameTooltip)
		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end
end

function f.OnHyperlinkLeave(self, link)
	if link ~= nil then
		local type = strmatch(link, "^(.-):")
		if(type == "item" or type == "enchant" or type == "spell" or type == "quest") then
			HideUIPanel(GameTooltip)
		end
	end
end

function f.OnUpdate(self, elapsed)
	ChatFrame1.timer = (ChatFrame1.timer or 0) + elapsed

	if ChatFrame1.timer >= 0.01 then
		if ChatFrame1.action == "shrink" and ChatFrame1:GetHeight() > f.collapsedHeight then
			local newHeight = ChatFrame1:GetHeight() - 50

			if newHeight < f.collapsedHeight then
				ChatFrame1:SetHeight(f.collapsedHeight)
			else
				ChatFrame1:SetHeight(newHeight)
			end
		elseif ChatFrame1.action == "grow" and ChatFrame1:GetHeight() < f.expandedHeight then
			local newHeight = ChatFrame1:GetHeight() + 50

			if newHeight > f.expandedHeight then
				ChatFrame1:SetHeight(f.expandedHeight)
			else
				ChatFrame1:SetHeight(newHeight)
			end
		end

		for i=1,NUM_CHAT_WINDOWS,1 do
			local cf = _G["ChatFrame"..i]
			local tab = _G["ChatFrame"..i.."Tab"]

			if cf:GetName() == "ChatFrame2" then
				cf:ClearAllPoints()
				cf:SetPoint("TOPLEFT", ChatFrame1, "TOPLEFT", 0, -24)
				cf:SetPoint("TOPRIGHT", ChatFrame1, "TOPRIGHT", 0, -24)
				cf:SetPoint("BOTTOMLEFT", ChatFrame1, "BOTTOMLEFT", 0, 0)
				cf:SetPoint("BOTTOMRIGHT", ChatFrame1, "BOTTOMRIGHT", 0, 0)
			elseif cf:GetName() ~= ChatFrame1:GetName() then
				cf:ClearAllPoints()
				cf:SetAllPoints(ChatFrame1)
			end

			tab:ClearAllPoints()
			if i == 1 then
				tab:SetPoint("TOPLEFT", ChatFrame1, "BOTTOMLEFT", 0, 4)
			else
				tab:SetPoint("LEFT", _G["ChatFrame"..(i-1).."Tab"], "RIGHT", 0, 0)
			end
                        
			ChatFrame1EditBox:ClearAllPoints()
			ChatFrame1EditBox:SetPoint("TOPLEFT", ChatFrame1Tab, "BOTTOMLEFT", 0, 4)
                        --ChatFrame1EditBox:SetPoint("BOTTOMLEFT", ChatFrame1Tab, "TOPLEFT", 0, -4)
			ChatFrame1EditBox:SetWidth(ChatFrame1:GetWidth())
		end

		ChatFrame1.timer = 0
	end
end

function f:UPDATE_CHAT_COLOR_NAME_BY_CLASS(type, enabled)
        if not enabled then
                SetChatColorNameByClass(type, true)
        end
end

function f:UPDATE_CHAT_WINDOWS(self, event, ...)
	for i=1,NUM_CHAT_WINDOWS,1 do
		local cf = _G["ChatFrame"..i]
		local tab = _G["ChatFrame"..i.."Tab"]

		cf.defaultLanguage = GetDefaultLanguage()

		if cf:GetName() == "ChatFrame2" then
			cf:ClearAllPoints()
			cf:SetPoint("TOPLEFT", ChatFrame1, "TOPLEFT", 0, -24)
			cf:SetPoint("TOPRIGHT", ChatFrame1, "TOPRIGHT", 0, -24)
			cf:SetPoint("BOTTOMLEFT", ChatFrame1, "BOTTOMLEFT", 0, 0)
			cf:SetPoint("BOTTOMRIGHT", ChatFrame1, "BOTTOMRIGHT", 0, 0)
		elseif cf:GetName() ~= "ChatFrame1" then
			cf:ClearAllPoints()
			cf:SetAllPoints(ChatFrame1)
		end

		tab:ClearAllPoints()
		if i == 1 then
			tab:SetPoint("TOPLEFT", ChatFrame1, "BOTTOMLEFT", 0, 4)
		else
			tab:SetPoint("LEFT", _G["ChatFrame"..(i-1).."Tab"], "RIGHT", 0, 0)
		end
                
		ChatFrame1EditBox:ClearAllPoints()
		ChatFrame1EditBox:SetPoint("TOPLEFT", ChatFrame1Tab, "BOTTOMLEFT", 0, 4)
		ChatFrame1EditBox:SetWidth(ChatFrame1:GetWidth())
           
		--ChatFrame1EditBox:SetBackdrop(nil)

                ChatFrame1EditBoxLeft:SetTexture(nil)
                ChatFrame1EditBoxMid:SetTexture(nil)
                ChatFrame1EditBoxRight:SetTexture(nil)
		--ChatFrame1EditBoxLeft:Hide()
                --ChatFrame1EditBoxMid:Hide()
		--ChatFrame1EditBoxRight:Hide()
		--ChatFrame1EditBox:Hide()

                if not ChatFrame1EditBox.bg then
                    ChatFrame1EditBox.bg = ChatFrame1EditBox:CreateTexture(nil, "BACKGROUND")
                    ChatFrame1EditBox.bg:SetAllPoints()
                    ChatFrame1EditBox.bg:SetColorTexture(0, 0, 0, 0.5)
                end
        
		cf:SetFont("Fonts\\ARIALN.TTF", f.FontSize+2, "OUTLINE")

		SetChatWindowAlpha(i, 0.8) -- Set the alpha of the chat window to 80%
		SetChatWindowColor(i, 0, 0, 0) -- Set the background color of the chat window to black

		cf:SetScript("OnEnter", f.OnEnter)
		cf:SetScript("OnLeave", f.OnLeave)
		cf:HookScript("OnHyperlinkEnter", f.OnHyperlinkEnter)
		cf:HookScript("OnHyperlinkLeave", f.OnHyperlinkLeave)
		cf:SetScript("OnUpdate", f.OnUpdate)

		cf:EnableKeyboard(true)
		cf:EnableMouse(true)
		cf:EnableMouseWheel(true)
		cf:SetFading(false)
	end
end

f:SetScript("OnEvent", function(self, event, ...)
	if self[event] then
		self[event](event, ...)
	end
end)

--f:SetScript("OnUpdate", f.OnUpdate)

ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_TEXT_EMOTE", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD_ACHIEVEMENT", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD_ITEM_LOOTED", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND", f.AddGuildInfo)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND_LEADER", f.AddGuildInfo)

--[[
for _, event in ipairs(ChatEvents) do
	ChatFrame_AddMessageEventFilter(event)
end
]]

f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("UPDATE_CHAT_WINDOWS")
f:RegisterEvent("UPDATE_CHAT_COLOR_NAME_BY_CLASS")
--f:RegisterEvent("VARIABLES_LOADED")
--f:RegisterEvent("CHAT_MSG_WHISPER")
--f:RegisterEvent("CHAT_MSG_WHISPER_INFORM")
--f:RegisterEvent("PLAYER_LOGIN")
--f:RegisterEvent("ADDON_LOADED")
